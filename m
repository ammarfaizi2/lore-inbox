Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSGVJej>; Mon, 22 Jul 2002 05:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSGVJej>; Mon, 22 Jul 2002 05:34:39 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:64516 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S316605AbSGVJei>; Mon, 22 Jul 2002 05:34:38 -0400
Date: Mon, 22 Jul 2002 10:03:29 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Thunder from the hill <thunder@ngforever.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@fs.tum.de>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit
In-Reply-To: <Pine.LNX.4.44.0207211908320.3309-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.30.0207220952300.614-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Jul 2002, Thunder from the hill wrote:

> > (e.g. umount gives EBUSY,
> Simply because you _will_ lose data if you umount a device that's being
> scribbled on.

Potentially you _will_ lose data in swapoff case. Kernel could know
when it's save to do but no way for admin to calculate.

	Szaka

