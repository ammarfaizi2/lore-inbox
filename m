Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129270AbRBNWFj>; Wed, 14 Feb 2001 17:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129661AbRBNWF3>; Wed, 14 Feb 2001 17:05:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28434 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129270AbRBNWFR>; Wed, 14 Feb 2001 17:05:17 -0500
Subject: Re: Are the sysctl and ptrace bugs already fixed ?
To: jldomingo@crosswinds.net (José Luis Domingo López)
Date: Wed, 14 Feb 2001 22:05:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010214224744.A1302@dardhal.mired.net> from "José Luis Domingo López" at Feb 14, 2001 10:47:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TA2y-0006Dh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> vulnerability in 2.2.18-pre9 (I suppose it was really 2.2.19-pre9). But
> with respect to the other two vulnerabilities on 2.2.x and the whole th=
> ree
> in kernel series 2.4.x haven't been able to find any information in
> neither Bugtraq, nor in the Linux kernel development archives.

2.2.19pre9 fixes the base ptrace attack, the sysctl bug. The PIII fpu bug
		doesnt apply to 2.2 unless you applied the PIII patches to it
	
2.4.0 didnt have the ptrace bug. The -ac tree has both sysctl and fpu fixed.
		I believe the current Linus 2.4.2pre has fpu but not sysctl
		fixed

