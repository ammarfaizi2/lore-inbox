Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbULAOtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbULAOtm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 09:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbULAOtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 09:49:42 -0500
Received: from imp.wsdmail.net ([204.113.120.5]:59084 "EHLO imp.wsdmail.net")
	by vger.kernel.org with ESMTP id S261263AbULAOtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 09:49:41 -0500
Message-ID: <1101913737.41adde8998978@imp.wsdmail.net>
Date: Wed,  1 Dec 2004 08:08:57 -0700
From: Michael Thomas Heath <mheath06@wsdmail.net>
To: linux-kernel@vger.kernel.org
Cc: Mike.Thomas.Heath@gmail.com
Subject: INVALID CHECKSUM error (In Linux Video Capture Interface?)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 204.113.113.59
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently underwent the effort to setup an older parallel Colour QuickCam on 
Linux using the Video4Linux interface. However, when I went to boot, I got 
an "INVALID CHECKSUM 0005" error:

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:09.0: 3Com PCI 3c900 Cyclone 10Mbps TPO at 0xd400. Vers LK1.1.19
 ***INVALID CHECKSUM 0005*** <6>Linux video capture interface: v1.00
Colour QuickCam for Video4Linux v0.05
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2


I've never encountered an error like this before; I asked around and people 
suggested testing my RAM (Which I did, everything was fine), and recompiling 
my kernel. I recompiled my kernel image, and used dd to copy to avoid errors 
in the copying of the kernel.

I'd apreaciate you CC any replies to my home e-
mail, "Mike.Thomas.Heath@gmail.com" 
