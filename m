Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292109AbSBAWY3>; Fri, 1 Feb 2002 17:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292105AbSBAWYU>; Fri, 1 Feb 2002 17:24:20 -0500
Received: from [195.163.186.27] ([195.163.186.27]:11470 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S292086AbSBAWYJ>;
	Fri, 1 Feb 2002 17:24:09 -0500
Date: Sat, 2 Feb 2002 00:23:53 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Anthony Campbell <ac@acampbell.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Repeated lockups caused by ext3?
Message-ID: <20020202002353.N5808@mea-ext.zmailer.org>
In-Reply-To: <20020201162055.GA1318@debian.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020201162055.GA1318@debian.local>; from ac@acampbell.org.uk on Fri, Feb 01, 2002 at 04:20:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 04:20:55PM +0000, Anthony Campbell wrote:
> For the past couple of months I have been getting repeated lockups using
> 2.4 kernels; 2.4.17 at present. They always occur when I'm on line and
> downloading, never at other times, and never on kernel 2.2.20. No
> particular process seems to cause it. When it happens, all keys are
> inoperative, the modem stops working, and the hard disk light is
> permanently on.
> 
> They never occur on my laptop, using kernel 2.4.17.
>
> They began to occur at about 2.4.10. I kept attributing them to VM
> issues and fiddled with all sorts of things in the BIOS, without
> result.
> 
> However, I've now found that they don't occur if I don't use ext3. This
> therefore seems to be the answer in my case. Is this a known issue, and
> is there any way of getting ext3 to work?
> 
> For the record: Processor is Intel Coppermine 600Mhz; 192M memory.
> Not using hdparm.

  Oh dear..  uniprocessor ?
  I get SMP machine to hang when writing 1+ GB file to EXT3 on RAID-1, and 
  having more than 512 MB memory...

> Anthony
> -- 
> Anthony Campbell - running Linux GNU/Debian (Windows-free zone)
> For an electronic book (The Assassins of Alamut), skeptical 
> essays, and over 150 book reviews, go to: http://www.acampbell.org.uk/

/Matti Aarnio
