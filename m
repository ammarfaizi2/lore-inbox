Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUFWAkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUFWAkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 20:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUFWAkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 20:40:42 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:61691 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264966AbUFWAkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 20:40:40 -0400
Date: Tue, 22 Jun 2004 20:34:04 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix sata_sil quirk
In-Reply-To: <40D8AED6.8050503@pobox.com>
Message-ID: <Pine.GSO.4.33.0406222031230.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004, Jeff Garzik wrote:
>Is this with my patch?

It is now.  Either way, max_sectors is staying 15.  I'll post the results
after it's had time to zero 40G a few dozen times.

>The full-speed fix requires splitting affected DMA writes into two
>separate commands, when the sector count matches "sectors % 15 == 1".

Why 15 I wonder?

--Ricky


