Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWCQUZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWCQUZX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWCQUZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:25:23 -0500
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:1875 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1751308AbWCQUZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:25:22 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.15.6 not finding everything on a Supermicro H8QC8 Quad Opteron 8132/nforce2200 
Date: Fri, 17 Mar 2006 14:37:48 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcZKAqc5jDFiom1bSW+Yx6JKsTViSQ==
Message-ID: <EXCHG2003y16xsoIIzQ000006f6@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 17 Mar 2006 20:17:52.0806 (UTC) FILETIME=[DEADD460:01C649FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am doing some testing on a Supermico H8QC8 Quad Opteron.

The distribution is SLES 9 SP2, and the SLES kernel 
appears to find everything and works, compiling 
the kernel.org 2.6.15.6 it fails to find anything
on the AMD 8132 part of the chipset, it does not even appear
to find the AMD 8132.

This motherboards can be found at:

http://www.supermicro.com/Aplus/motherboard/Opteron/nForce/H8QC8.cfm


According to the block diagram the 8132 is tied off of
CPU#2, and the nforce 2200 is tied off of cpu#1.

I will be sending the .config/dmesg/lspci and such if necessary,
right now the machine is offline, I have a feeling though that
the problem is a lot more basic since lspci indicates that it did
not find anything attached to the second cpu except memory.  I
did verify that the kernel.org kernel sees 4 cpus, and of the
installed ram.

Does 2.6.16rcx have changes that could address this issue?  Or is
there something that I could be missing in the config (the config
was copied from the original suse config + make oldconfig) or
is there some kernel boot option that could help?

                               Roger

