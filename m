Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262548AbTCIRTh>; Sun, 9 Mar 2003 12:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262549AbTCIRTh>; Sun, 9 Mar 2003 12:19:37 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:21703 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262548AbTCIRTh>; Sun, 9 Mar 2003 12:19:37 -0500
Date: Sun, 9 Mar 2003 12:35:51 -0500
To: akpm@digeo.com, piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63-mm2
Message-ID: <20030309173551.GA3055@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.64-mm1 on K6/2 uniprocessor completed the 24 hour benchmarks
using anticipatory scheduler with no oops.  (Badness in request_irq 
at arch/i386/kernel/irq.c:475 is known and non-fatal).

2.5.64-mm1 had ~ 47% improvement in tiobench sequential read 
throughput on ext2, compared to 2.5.64 on uniprocessor K6/2.

2.5.64-mm2 ran dbench, Linux Test Project, unixbench, lmbench
with no problems on uniprocessor too.

2.5.64-mm4 is running on Quad Xeon now, and has finished dbench
runs with no oops.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

