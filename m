Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312998AbSDEP3d>; Fri, 5 Apr 2002 10:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313005AbSDEP3Y>; Fri, 5 Apr 2002 10:29:24 -0500
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:52647 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S312998AbSDEP3N>; Fri, 5 Apr 2002 10:29:13 -0500
Date: Fri, 5 Apr 2002 17:29:12 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: linux-kernel@vger.kernel.org
Subject: /arch/ppc64/kernel/setup.c
Message-ID: <Pine.GSO.4.05.10204051725280.19854-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,

can someone please explain to me who calibrate_delay works in
arch/ppc64/kernel/setup.c?

as i can see it calibrate.c is a global function defined in init/main.h.
arch/ppc64/kernel/setup.c sets a pointer to the address of this function
extern void (*calibrate_delay)(void); and assigns its own routine to that
pointer. - hmm, every time i tried to do similar things (by mistake :),
the program segfaulted on me.

- can someone please explain how this should work?

thanks,

	tm

-- 
in some way i do, and in some way i don't.

