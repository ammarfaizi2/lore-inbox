Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTKPQaG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 11:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTKPQaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 11:30:06 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:45696 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262955AbTKPQaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 11:30:01 -0500
Subject: [Bug 1303] 2.6.0-test4, test5, test6, test7, test8, test9 very
	very slow with smp kernel
From: Zatalian <zatalian@pandora.be>
To: linux-kernel@vger.kernel.org
Cc: DiegoCG@teleline.es
In-Reply-To: <200311161500.hAGF0Hbh005350@fire-1.osdl.org>
References: <200311161500.hAGF0Hbh005350@fire-1.osdl.org>
Content-Type: text/plain
Message-Id: <1069000200.4225.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 16 Nov 2003 17:30:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1303

Hi,

Diego suggested sending my bug to this email-adress so maybe some
kernel-developer can tell me what is happening with my computer and if
other people suffer the same problem.

This is what i get : 

Since kernel 2.6.0-test4 my system becomes very slow when using an
smp-kernel.

I have a DELL poweredge 2400 dual PIII 733 Mhz machine with 768 Mb sdram
and some SCSI disks 
I use ext3 for my boot partition and reiserfs for my root partition.

Right now I use kernel 2.6.0-test2 with smp without any problems.

This problem is not X related. Just booting without loading the nvidia
module, logging into the console and shutting down takes more than 10
minutes. With a normal kernel, this would take max. 2 minutes. Most
things become very slow (but other commands like "dmesg >
dmesg.2.6.0-test9" are as fast as always).

The only thing I found different between a normal working kernel and a
buggy kernel are the following lines in my dmesg : 


>> Losing too many ticks!
>> TSC cannot be used as a timesource. (Are you running with SpeedStep?)
>> Falling back to a sane timesource.

I don't have them when running a normal kernel.

I hope somebody can tell me what's going on here.

Thanks.

Zatalian.

