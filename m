Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTEKL6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 07:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTEKL6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 07:58:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6300 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261292AbTEKL6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 07:58:23 -0400
Date: Sun, 11 May 2003 14:10:46 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Grzesiek Wilk <toulouse@put.mielec.pl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SiS648 support for agpgart, kernel 2.4.21-rc2-ac1
In-Reply-To: <200305111311.31915.toulouse@put.mielec.pl>
Message-ID: <Pine.SOL.4.30.0305111409470.1501-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 May 2003, Grzesiek Wilk wrote:

> This patch just adds sis648 chipset support as a generic sis chipset into
> agpgart. You need it if you want to get a 3d acceleration to work.
>
> So far it works fine on my Radeon 9000
> (glxgears 1200fps instead of 300, glTron works excellent).
>
> One thing i'm not sure is in which agp mode it is working. SiS648 as well as
> R9k supports agp 3.0 but I don't think that generic sis driver does.
> (correct me if i'm wrong).

You are wrong, R9k -> no AGP3.0 ;-).
--
Bartlomiej

