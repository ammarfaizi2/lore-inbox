Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263747AbTKXKI5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 05:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbTKXKI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 05:08:57 -0500
Received: from [194.118.56.16] ([194.118.56.16]:63928 "EHLO mia.0xff.at")
	by vger.kernel.org with ESMTP id S263747AbTKXKIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 05:08:55 -0500
Subject: LSI53C1030 (Fustion MPT) performance
From: Karl Pitrich <pit@0xff.at>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069668564.2372.127.camel@warp.fabafsc.fabagl.fabasoft.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 24 Nov 2003 11:09:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i got a new ibm intellistation z pro dual xeon (6221-49G) with on board 
Fusion MPT chipset (LSI53C1030) and fast U160 disks.

2.4.20-8 (redhat) and 2.6.0-test9-vanilla 
(each customer compiled minimal kernels) 
both yield very poor disk performance.

i didn't do specific benkchmarking, but mv'ing a 3GB $HOME to another
partition takes at least 4x the time as on my old P4 workstation with
IDE drive.

is poor performance with this controller a known problem?
could that have to do something with smp?

in 2.6.0, the driver's cvs-versions seem to match the ones in the
sources offered by LSI for download.
lkml-archives and google weren't all too helpful.

any info/help apreciated,


 / karl


PS: in the course of this i studied dmesg and found:

  calibrating APIC timer ...
  ..... CPU clock speed is 3066.0234 MHz.
  ..... host bus clock speed is 133.0314 MHz.

is 'host bus clock speed' != front side bus speed?
this shows up also on other p4 machines with much faster FSB than 133
mhz.




