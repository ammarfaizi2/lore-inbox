Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbSLFQF7>; Fri, 6 Dec 2002 11:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSLFQF7>; Fri, 6 Dec 2002 11:05:59 -0500
Received: from [207.61.129.108] ([207.61.129.108]:49545 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S263256AbSLFQF7>; Fri, 6 Dec 2002 11:05:59 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PROBLEM]: 2.5.50 w/ module-init-tools 0.9.1 and 0.8 - Invalid module format w/ NEWS patch
Date: Fri, 6 Dec 2002 11:13:34 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200212061113.34741.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After patching 2.5.50 with the patch from the NEWS file, and recompiling completely the kernel and modules I'm not able to load modules:

file gameport.o:
gameport.o: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), not stripped

insmod:
Error inserting `./gameport.o': -1 Invalid module format

modprobe:
FATAL: Error inserting gameport (/lib/modules/2.5.50/kernel/gameport.o): Invalid module format

This occurs with 0.8 and 0.9.1

Any solutions? I really need module support because there are some PnP issues that I'm trying to help solve.

Shawn.

-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

