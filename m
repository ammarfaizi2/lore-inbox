Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270823AbTG1Tkk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270827AbTG1Tkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:40:40 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:51677 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S270823AbTG1Tkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:40:35 -0400
Date: Mon, 28 Jul 2003 12:40:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 999] New: Problem with the /dev/ptmx file
Message-ID: <3898100000.1059421220@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=999

           Summary: Problem with the /dev/ptmx file
    Kernel Version: 2.6.0-test2
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: areversat@tuxfamily.org
                CC: areversat@tuxfamily.org


Distribution: Gentoo GNU/Linux
Hardware Environment: P4 2.0Ghz 512 mo ram, Ati Radeon 9000 Mobility
Software Environment: Linux 2.6.0-test2
Problem Description:
When i want to open an Eterm or an xterm (whatever until it uses a virtual
terminal) it fails saying granpt(4) failed.
I've traced the program and it seems that it calls /dev/ptmx well but that ptmx
doesn't create the right entry in /dev/pts.
Note : I don't have /dev/pts support in my kernel but it works with a 2.4 like
that... And i also tried with it compiled in and it didn't work either.

Steps to reproduce:
For me you only have to open something using a virtual terminal.
It may be a configuration problem but i searched and didn't find where it was...


