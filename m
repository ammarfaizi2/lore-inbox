Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281839AbRK1BHV>; Tue, 27 Nov 2001 20:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281843AbRK1BHL>; Tue, 27 Nov 2001 20:07:11 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:18181 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S281839AbRK1BHD>;
	Tue, 27 Nov 2001 20:07:03 -0500
Date: Tue, 27 Nov 2001 18:03:22 -0800
From: Greg KH <greg@kroah.com>
To: Eric Streit <Eric.Streit@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: one missing line in ov511.c
Message-ID: <20011127180322.A14109@kroah.com>
In-Reply-To: <20011127084150.A11807@sarah.maison.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011127084150.A11807@sarah.maison.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 30 Oct 2001 23:47:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 08:41:50AM +0100, Eric Streit wrote:
> hi,
> 
> a short mail to report a small bug in "ov511.c".
> (drivers/usb/ov511.c)
> 
> the line defining the kernel version is missing in the kernel 2.2.20.
> 
> I downloaded it 2 days ago.
> 
> ************line  missing**************
> static char kernel_version[] = UTS_RELEASE;
> ************end of line missing********
> 
> I am at work, so I have only the 2.2.19 kernel, so I cannot say
> the right line, but it's just under the "MODULE_DESCRIPTION" line.

I don't understand, ov511.c in 2.2.20 compiles just fine for me.  What
is the error message that you see?

thanks,

greg k-h
