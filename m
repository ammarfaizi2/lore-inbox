Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbTBDJO5>; Tue, 4 Feb 2003 04:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbTBDJO5>; Tue, 4 Feb 2003 04:14:57 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:7323 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267190AbTBDJO4>; Tue, 4 Feb 2003 04:14:56 -0500
Message-ID: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
From: =?iso-8859-1?Q?Thomas_B=E4tzler?= <t.baetzler@bringe.com>
To: linux-kernel@vger.kernel.org
Subject: filesystem access slowing system to a crawl 
Date: Tue, 4 Feb 2003 10:29:08 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

maybe you could help me out with a really weird problem we're having
with a NFS fileserver for a couple of webservers:

- Dual Xeon 2.2 GHz
- 6 GB RAM
- QLogic FCAL Host adapter with about 5.5 TB on a several RAIDs
- Debian "woody" w/Kernel 2.4.19

Running just "find /" (or ls -R or tar on a large directory) locally
slows the box down to absolute unresponsiveness - it takes minutes
to just run ps and kill the find process. During that time, kupdated
and kswapd gobble up all available CPU time. 

The system performs great otherwise, so I've ruled out a hardware
problem. It can't be a load problem because during normal operation,
the system is more or less bored out of its mind (70-90% idle time).

I'm really at the end of my wits here :-(

Any help would be greatly appreciated!

TIA,
Thomas

