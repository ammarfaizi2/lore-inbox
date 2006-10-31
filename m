Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161531AbWJaBPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161531AbWJaBPA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 20:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161566AbWJaBPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 20:15:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25606 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161531AbWJaBO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 20:14:59 -0500
Date: Tue, 31 Oct 2006 02:14:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb device descriptor read/64, error -110
Message-ID: <20061031011458.GP27968@stusta.de>
References: <45468ABC.1060100@perkel.com> <20061030235429.GO27968@stusta.de> <454691E4.6000807@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454691E4.6000807@perkel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 03:59:32PM -0800, Marc Perkel wrote:
> 
> 
> Adrian Bunk wrote:
> >On Mon, Oct 30, 2006 at 03:29:00PM -0800, Marc Perkel wrote:
> >  
> >>Running the latest FC6 kernel based on 2.6.18.1. What does this error 
> >>mean?
> >>
> >>device descriptor read/64, error -110
> >>
> >>Is this a kernel bug? Thanks in advance?
> >>    
> >
> >That's a timeout.
> >
> >Your bug report lacks any any information for further debugging your 
> >problem.
> >
> >- When does it occur?
> >- What is failing?
> >- Please send the output of "dmesg -s 1000000".
> >
> >And please read and follow REPORTING-BUGS in the kernel sources before 
> >sending your next bug report.
> >
> >cu
> >Adrian
> >
> >  
> 
> Thanks for your help. The device is a module that lets me plug in 
> various kinds og camera memory sticks.
> 
> usb 1-7: new full speed USB device using ohci_hcd and address 2
> usb 1-7: device descriptor read/64, error -110
> usb 1-7: device descriptor read/64, error -110
> usb 1-7: new full speed USB device using ohci_hcd and address 3
> usb 1-7: device descriptor read/64, error -110

Please send the _complete_ output of "dmesg -s 1000000".
If you want help, you should include as much information as possible.

If you are concerned about the size of your email, please remember that 
linux-kernel has a 100 kB size limit - and everything smaller is 
perfectly OK.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

