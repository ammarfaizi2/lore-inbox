Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291173AbSBLU6I>; Tue, 12 Feb 2002 15:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291177AbSBLU57>; Tue, 12 Feb 2002 15:57:59 -0500
Received: from holomorphy.com ([216.36.33.161]:60323 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291173AbSBLU5q>;
	Tue, 12 Feb 2002 15:57:46 -0500
Date: Tue, 12 Feb 2002 12:57:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Re: File BlockSize
Message-ID: <20020212205722.GH767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	riel@surriel.com
In-Reply-To: <002e01c1b397$1a26d270$3c00a8c0@baazee.com> <E16ae3z-0001xO-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <E16ae3z-0001xO-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 02:37:43PM +0000, Alan Cox wrote:
> Going to a block size bigger than page size causes all sorts of fun with 
> allocation failures if there are not two pages free adjacent to one another
> when allocating, and isn't really worth the cost.

This sounds like fairly severe memory fragmentation, which seems more
worrisome to me than blocksize constraints. Should I look into that?


Cheers,
Bill
