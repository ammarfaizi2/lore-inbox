Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbRDQT6n>; Tue, 17 Apr 2001 15:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131348AbRDQT6e>; Tue, 17 Apr 2001 15:58:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13841 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130493AbRDQT6V>; Tue, 17 Apr 2001 15:58:21 -0400
Subject: Re: AHA-154X/1535 not recognized any more
To: markus.schaber@student.uni-ulm.de (Markus Schaber)
Date: Tue, 17 Apr 2001 20:59:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.SOL.4.33.0104172009480.16832-100000@lyra.rz.uni-ulm.de> from "Markus Schaber" at Apr 17, 2001 08:42:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pbdW-000368-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now I have the problem that kernels 2.4.2 and 2.4.3 don't recognize this
> adapter any more, while all 2.2-kernels I used (I currently remember
> 2.2.19, 2.2.18 and debian-2.2.17pre6) work with it without problems.

Load the module with isapnp=1. It defaults to not scanning isapnp boards which
strikes me as odd. Let me know if that fixes it if so I think I'll tweak the
default
