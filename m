Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272888AbTG3Ow6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272885AbTG3Ow6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:52:58 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:40389 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S272932AbTG3Ovq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:51:46 -0400
Date: Wed, 30 Jul 2003 07:51:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1013] New: ide bus reset, never gets out of loop
Message-ID: <16180000.1059576690@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1013

           Summary: ide bus reset, never gets out of loop
    Kernel Version: Debian sid kernel 2.6.1 test i386
            Status: NEW
          Severity: normal
             Owner: bzolnier@elka.pw.edu.pl
         Submitter: hjh@passys.nl


Distribution: Debian sid 
Hardware Environment: IBM Thinkpad i240 
Software Environment: Debian sid package 
Problem Description: On boot, the system always says the unmount was unclean, fsck 
necessary. The fsck loops at 64% on an ide bus reset (which it claims to be succcesfull), 
but at this point, it loops in an ide reset loop. 
The remedy: remove 2.6, mount unclean, do a manual fsck. 
Additional issue: this procedure (of resetting the ide controller) seems to have wrecked 
the boot sector, and some files on the root disk. 
 
Steps to reproduce: Install and use kernel 2.6 from Debian sid on an IBM i240


