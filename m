Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317082AbSEXDYm>; Thu, 23 May 2002 23:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317081AbSEXDYk>; Thu, 23 May 2002 23:24:40 -0400
Received: from holomorphy.com ([66.224.33.161]:9627 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317079AbSEXDYj>;
	Thu, 23 May 2002 23:24:39 -0400
Date: Thu, 23 May 2002 20:24:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loop.c forgot a kmap
Message-ID: <20020524032430.GC2035@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Benjamin LaHaise <bcrl@redhat.com>, linux-fsdevel@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020523232024.A2917@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 11:20:25PM -0400, Benjamin LaHaise wrote:
> The patch below fixes a bug in loop.c that causes highmem systems 
> to fail spectacularly when a page happens to be allocated in highmem 
> by replacing the use of page_address with a kmap/kunmap sequence.  

Looks good; IMHO it should be applied.


Cheers,
Bill
