Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317307AbSGODuj>; Sun, 14 Jul 2002 23:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSGODui>; Sun, 14 Jul 2002 23:50:38 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:16834 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S317307AbSGODui>; Sun, 14 Jul 2002 23:50:38 -0400
Date: Mon, 15 Jul 2002 05:53:54 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Andries Brouwer <aebr@win.tue.nl>,
       A Guy Called Tyketto <tyketto@wizard.com>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
In-Reply-To: <20020714200119.E27798@ucw.cz>
Message-ID: <Pine.GSO.3.96.1020715055117.22261A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, Vojtech Pavlik wrote:

> The problem is that 0xff takes too long to finish to be done while Linux
> is booting, and it has already been done by the BIOS.

 Certainly, you don't have to poll, do you?  Just send the command and let
the kernel proceed.  Resume initialization in the IRQ handler, when a
response arrives (or never).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

