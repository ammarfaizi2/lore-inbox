Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbTKGEfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 23:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTKGEfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 23:35:00 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:26734 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261347AbTKGEe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 23:34:59 -0500
Date: Fri, 7 Nov 2003 06:35:03 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Maciej Zenczykowski <maze@cela.pl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: undo an mke2fs !!
In-Reply-To: <Pine.LNX.4.44.0311061753350.21501-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.58.0311070601380.10194@ua178d119.elisa.omakaista.fi>
References: <Pine.LNX.4.44.0311061753350.21501-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Nov 2003, Maciej Zenczykowski wrote:

> So anything like e2image available for reiserfs?

AFAIK, no for other filesystems (saving only metadata), only for NTFS
(e2image gave the inspiration):

	http://linux-ntfs.sourceforge.net/man/ntfsclone.html

It clones either all used data or only metadata to a mountable image at the
sector level (so it's much more efficient than dd if disk is far away to be
full).

	Szaka
