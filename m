Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264492AbRFIXiu>; Sat, 9 Jun 2001 19:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264491AbRFIXij>; Sat, 9 Jun 2001 19:38:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46089 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263916AbRFIXic>; Sat, 9 Jun 2001 19:38:32 -0400
Subject: Re: [patch] ess maestro, support for hardware volume control
To: pfaffben@msu.edu
Date: Sun, 10 Jun 2001 00:36:21 +0100 (BST)
Cc: alan@redhat.com (Alan Cox), lukas@edeal.de (Lukas Schroeder),
        zab@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <87elst2vr2.fsf@pfaffben.user.msu.edu> from "Ben Pfaff" at Jun 09, 2001 05:23:13 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E158sHF-0004Vl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, what is the officially approved way to open a device on a
> dynamic misc minor?  Reading /proc/misc for the minor number,

Ask for minor 0 I believe, then load the module then see what you got.

> then mknod'ing a device and opening it seems to me to have a
> nasty race condition, am I missing something here?

Ultimately if its a device of its own it probably wants to be part of the
input device frame work - as for example the volume knob on my USB speakers is

