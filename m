Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUJSGcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUJSGcI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 02:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUJSGcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 02:32:08 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:59888 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S268037AbUJSGcB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 02:32:01 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Weird... 2.6.9 kills FC2 gcc
Date: Tue, 19 Oct 2004 02:31:58 -0400
User-Agent: KMail/1.7
Cc: Jeff Garzik <jgarzik@pobox.com>
References: <4174697B.90306@pobox.com>
In-Reply-To: <4174697B.90306@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410190231.58570.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.58.180] at Tue, 19 Oct 2004 01:32:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 October 2004 21:10, Jeff Garzik wrote:
>The following appears in 2.6.9 release kernel, building with stock
> FC2
>
>gcc on x86, but does not appear in 2.6.9-final:
>>   AS      arch/i386/kernel/vsyscall.o
>> cc1: internal compiler error: Segmentation fault
>> Please submit a full bug report,
>> with preprocessed source if appropriate.
>> See <URL:http://bugzilla.redhat.com/bugzilla> for instructions.
>> make[1]: *** [arch/i386/kernel/vsyscall.o] Error 1
>> make: *** [arch/i386/kernel] Error 2
>
>This is 100% reproducible, at the same location (vsyscall), which is
>strange because vsyscall didn't change AFAICS.
>
>I'll build a gcc 3.4.2 without Fedora Core patches and see if the
>behavior persists.
>
>But in the meantime, if anybody else knows what line of code causes
> this segfault, please speak up :)
>
> Jeff

I'm an FC2, gcc-3.3.3 user, and it works here without that error, 
Jeff.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
