Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbUDQCTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 22:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUDQCTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 22:19:07 -0400
Received: from dx.caltech.edu ([131.215.159.62]:4250 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263669AbUDQCS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 22:18:27 -0400
Message-Id: <200404170219.i3H2JYal007333@localhost.localdomain>
Reply-To: <stl@nuwen.net>
From: "Stephan T. Lavavej" <stl@nuwen.net>
To: <linux-kernel@vger.kernel.org>
Subject: Process Creation Speed
Date: Fri, 16 Apr 2004 19:16:23 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQkIfrBxZ8d+yvyRValf2l2126aDg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does creating and then terminating a process in GNU/Linux take about 6.3
ms on a Prestonia-2.2?  I observe basically the same thing on a PIII-600.

I'm pretty sure both systems run 2.4.x kernels.  Does this suck less under
2.6.x?  Not sucking at all would mean about 100 microseconds to me.  I don't
understand why it doesn't scale with processor speed.  Does this interact
with the length of a timeslice?
 
It matters to me because the Common Gateway Interface spawns and destroys a
process to handle each request, and I wish it were just fast, rather than
having to use FastCGI.

A fair amount of Googling and RTFFAQ didn't answer this.

Stephan T. Lavavej
http://nuwen.net


