Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264314AbUEDLT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbUEDLT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 07:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUEDLT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 07:19:57 -0400
Received: from p508B626F.dip.t-dialin.net ([80.139.98.111]:2674 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S264272AbUEDLTz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 07:19:55 -0400
Date: Tue, 4 May 2004 13:19:02 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       macro@ds2.pg.gda.pl
Subject: Re: [PATCH] remove dead drivers/ide/ppc/swarm.c
Message-ID: <20040504111902.GA14240@linux-mips.org>
References: <200405040134.22092.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405040134.22092.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 01:34:22AM +0200, Bartlomiej Zolnierkiewicz wrote:

> This driver was merged in 2.5.32 but depends on <asm/sibyte/swarm_ide.h>
> which hasn't been merged in 2.5.  Additionally it is a MIPS specific driver
> so it should be in drivers/ide/mips/ if somebody ever decides to re-add it.

No.  I've already sent a proper patch instead of just a chainsaw massacre
to akpm.

  Ralf
