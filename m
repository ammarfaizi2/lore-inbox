Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSJLR5f>; Sat, 12 Oct 2002 13:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261313AbSJLR5f>; Sat, 12 Oct 2002 13:57:35 -0400
Received: from holomorphy.com ([66.224.33.161]:24198 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261305AbSJLR5e>;
	Sat, 12 Oct 2002 13:57:34 -0400
Date: Sat, 12 Oct 2002 10:59:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange patch to the Z85230 driver.
Message-ID: <20021012175957.GF10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1034445749.15067.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034445749.15067.6.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 07:02:29PM +0100, Alan Cox wrote:
> These are DMA ring buffers for ISA DMA, they do not need to be zeroed. 

get_free_page() was #defined to get_zeroed_page() to begin with.

/mnt/b/2.5.38/linux-2.5/include/linux/gfp.h:83:#define get_free_page get_zeroed_page


Bill
