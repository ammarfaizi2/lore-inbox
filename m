Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285703AbRL3XCF>; Sun, 30 Dec 2001 18:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285709AbRL3XBz>; Sun, 30 Dec 2001 18:01:55 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:34569 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S285703AbRL3XBw>;
	Sun, 30 Dec 2001 18:01:52 -0500
Date: Mon, 31 Dec 2001 00:01:50 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Sparc SS10 bootup problem
Message-ID: <20011231000150.A5705@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm trying to boot a freshly co'ed kernel (2.5.2-pre1) on a Sparc
SS10, but I'm facing some trouble:

boot: 1/boot/vmlinuz-2.5.2-pre1--01 console=ttya root=/dev/hda1 ro
PROMLIB: obio_ranges 5
Using /dev/ttya as console.
Fixup b f01e6fcc doesn't refer to a SETHI at f00156c0[900a20ff]
Program terminated
Type  help  for more information
<#0> ok 

>From matching System.map:
f01e6fb8 d startup.1562
f01e6fcc D ___bs_smp_processor_id
f01e6fcc D ___btfixup_start
f01e9c30 D ___bs_load_current

and

f0015014 t inflate_fixed
f001518c t inflate_dynamic
f0015850 t inflate_block


What can I do there, and (more important:-) what's a SETHI at all?
I haven't got an Architecture Reference Manual handy...

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/
