Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275046AbTHFXbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275050AbTHFXbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:31:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:63458 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S275046AbTHFXbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:31:00 -0400
Date: Thu, 7 Aug 2003 01:30:38 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Michael Buesch <fsdeveloper@yahoo.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>, Willy Gardiol <gardiol@libero.it>
Subject: Re: [2.6] system is very slow during disk access
In-Reply-To: <200308070116.18108.fsdeveloper@yahoo.de>
Message-ID: <Pine.SOL.4.30.0308070129050.19328-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Aug 2003, Michael Buesch wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Thursday 07 August 2003 01:01, Bartlomiej Zolnierkiewicz wrote:
> > Please send dmesg and .config.
>
> I've attached them to this mail.

After removing CONFIG_IDEDMA_IVB=y from your config
"Speed warnings" should go away.

--
Bartlomiej

