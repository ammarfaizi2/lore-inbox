Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTAVPjH>; Wed, 22 Jan 2003 10:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbTAVPjH>; Wed, 22 Jan 2003 10:39:07 -0500
Received: from postoffice.Princeton.EDU ([128.112.129.120]:41637 "EHLO
	Princeton.EDU") by vger.kernel.org with ESMTP id <S261364AbTAVPjG>;
	Wed, 22 Jan 2003 10:39:06 -0500
Date: Wed, 22 Jan 2003 10:48:13 -0500 (EST)
From: Canturk ISCI <canturk@alteon-01-vip1.Princeton.EDU>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: LKM - unresolved symbol
In-Reply-To: <DEEBJHMCKLIHOCFBLNCCGEMOCDAA.znmeb@aracnet.com>
Message-ID: <Pine.GSO.4.44.0301221037170.9165-100000@yuma.Princeton.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

when I want to use an external function/data in my LKM, say I want to use
cpuid from processor.h, I include processor.h in my KLM, and call cpuid.
It compiles fine, but when I try to insmod it, I get unresolved symbol
cpuid.
This happens quite often when I try to use something from outside. I've
read i386_ksyms.c doesn't export those symbols and this causes the problem
when insmod tries to link them.
I am wondering if there is a way around this unresolved symbol problem, or
if I get something wrong.
thanks...



