Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263607AbRFKTRu>; Mon, 11 Jun 2001 15:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263630AbRFKTRk>; Mon, 11 Jun 2001 15:17:40 -0400
Received: from rigel.cs.pdx.edu ([131.252.208.59]:28802 "EHLO rigel.cs.pdx.edu")
	by vger.kernel.org with ESMTP id <S263607AbRFKTR0>;
	Mon, 11 Jun 2001 15:17:26 -0400
Date: Mon, 11 Jun 2001 12:17:21 -0700 (PDT)
From: Naren Devaiah <naren@cs.pdx.edu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.6pre2: Unresolved symbols in 3c59x
Message-ID: <Pine.GSO.4.21.0106111212410.16983-100000@spica.cs.pdx.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Building 2.4.6pre2 with 3c59x.c as a module causes do_softirq to be
reported as an unresolved symbol during module load.

2.4.6pre1 has a similar problem


2.4.5 works without a fuss.

Versions:
modutils 2.4.6
egcs 1.1.2


-Naren

