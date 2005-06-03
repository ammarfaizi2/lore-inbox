Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVFCP1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVFCP1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 11:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVFCP1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 11:27:15 -0400
Received: from mxsf16.cluster1.charter.net ([209.225.28.216]:57837 "EHLO
	mxsf16.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261326AbVFCP0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 11:26:50 -0400
X-IronPort-AV: i="3.93,166,1115006400"; 
   d="scan'208"; a="342110487:sNHT22550790"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17056.30388.197641.477214@smtp.charter.net>
Date: Fri, 3 Jun 2005 11:26:44 -0400
From: "John Stoffel" <john@stoffel.org>
To: Dieter.Ferdinand@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.2 against 2.4 on old dual-pentium system with intel hx-chipset
In-Reply-To: <42A0889D.17491.5D69AF42@localhost>
References: <42A0889D.17491.5D69AF42@localhost>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dieter> i have a big problem with my old dual-pentium-systems with
Dieter> intel hx-chipset (gigabyte and asus mainboards).

Dieter> if i use kernel 2.2, it works fine. with kernel 2.4 i must
Dieter> deactivate smp and i can only use one cpu. if i try to use
Dieter> both cpu's, the system hangs after some ours or after some
Dieter> times of heavy system-load.

What version of 2.2 and 2.4 are you using here?  Be specific!  Also,
send the output of /proc/cpuinfo from both 2.2 and 2.4 along with
/proc/interrupts as well.  

Dieter> i try some parameters (noacpi noapic) without success.

And does the system pass memtest86 for an extended amount of time?
Say 24 hours?  

I ran some HP Pavillion Dual processor PPro systems for quite a while
under kernel 2.4 without major problems.  

Dieter> can you help me, to get the newer kernel running on this systems ?

Sure, just post as many details as possible.  

Do you get any output on the console when the system freezes?  You
should also look into setting up a serial console along with SysRq so
you can try to get some debugging output when the next hang happens.  

John
