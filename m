Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUEDO1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUEDO1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 10:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUEDO1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 10:27:53 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:61605 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264379AbUEDO1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 10:27:51 -0400
Date: Tue, 4 May 2004 16:27:50 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead drivers/ide/ppc/swarm.c
In-Reply-To: <200405041510.41731.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.55.0405041621370.32082@jurand.ds.pg.gda.pl>
References: <200405040134.22092.bzolnier@elka.pw.edu.pl>
 <200405041428.50592.bzolnier@elka.pw.edu.pl> <20040504124349.GA15664@linux-mips.org>
 <200405041510.41731.bzolnier@elka.pw.edu.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2004, Bartlomiej Zolnierkiewicz wrote:

> > Simply a result of the way the IDE bus is hooked up to the generic bus of
> > the Sibyte chip.  I'd have to research details if you're interested ...
> 
> The basic question is whether disk used on SiByte can be read i.e. on x86.
> If not than we may have serious problems with some special commands with
> current implementation (similar problem as on Atari Q40/Q60).

 I can check the GPIO attachment with 2.4 (which should behave the same
way here).  I don't have a PCI IDE board.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
