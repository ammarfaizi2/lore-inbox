Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263596AbUECFRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUECFRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 01:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUECFRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 01:17:36 -0400
Received: from web13901.mail.yahoo.com ([216.136.175.27]:45716 "HELO
	web13901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263596AbUECFRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 01:17:34 -0400
Message-ID: <20040503051733.41271.qmail@web13901.mail.yahoo.com>
Date: Sun, 2 May 2004 22:17:33 -0700 (PDT)
From: Bill Catlan <wcatlan@yahoo.com>
Subject: Re: Possible to delay boot process to boot from USB subsystem?
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040502182731.1e1cced6.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Randy.  As the below output shows, your patch
applies cleanly to 2.4.26 source, but I have not yet
had the chance to compile and test my configuration.

[root@plain linux-2.4.26]# patch init/do_mounts.c
usbboot-2422.patch 
patching file init/do_mounts.c
Hunk #1 succeeded at 367 (offset 1 line).

Bill
 

--- "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> I updated that patch to 2.4.22 but haven't checked
> it since then.
> I can't test it... if you can, that would be great.
> If it doesn't apply cleanly to 2.4.26, let me know
> and I'll work
> on it.
> 
> Patch is here:
>  
> http://www.xenotime.net/linux/usb/usbboot-2422.patch
> 
> --
> ~Randy



	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
