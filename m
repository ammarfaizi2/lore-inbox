Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317065AbSEXBN1>; Thu, 23 May 2002 21:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSEXBN0>; Thu, 23 May 2002 21:13:26 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:270 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317065AbSEXBN0>; Thu, 23 May 2002 21:13:26 -0400
Date: Fri, 24 May 2002 03:13:22 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre8-ac5 swsusp panic
Message-ID: <20020524011322.GA6612@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried SysRq-D and finally got a kernel "panic: Request while ide driver
is blocked?"

Before that, I saw "waiting for tasks to stop... suspending kreiserfsd",
nfsd exiting, "Freeing memory", "Syncing disks beofre copy", then some
"Probem while suspending", then some "Resume" and finally the panic.

It may be worth noting that one swap partition is on a SCSI drive, and
that my IDE drives were in standby (not idle) mode, i. e. their spindle
motors were stopped.

-- 
Matthias Andree
