Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbTL1BvP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 20:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbTL1BvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 20:51:15 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:24764 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264916AbTL1BvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 20:51:14 -0500
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.x CONFIG_BLK_DEV_IDE_MODES long dead
References: <Pine.LNX.4.10.10312271510260.32122-100000@master.linux-ide.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 28 Dec 2003 02:31:43 +0100
In-Reply-To: <Pine.LNX.4.10.10312271510260.32122-100000@master.linux-ide.org> (Andre
 Hedrick's message of "Sat, 27 Dec 2003 15:11:27 -0800 (PST)")
Message-ID: <m3r7ypram8.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> writes:

> Would you like to explain why they are gone?
> Just to humor the oldman.

I understand you refer to my mail (you know, that top-posting can be
misleading).

If "they" means zombies then they aren't gone yet, this is my patch
which removes them, and it does so because the variable in question,
CONFIG_BLK_DEV_IDE_MODES, is not longer being referenced by the kernel
code.

If "they" means CONFIG_BLK_DEV_IDE_MODES config variable then, obviously,
I don't know why it's no longer used, as I'm not the one who removed
the references (for 2.4 it was in 2.4.21 patch, haven't checked 2.6, you
may want to investigate it yourself).

What I'm trying to do is cleaning up the 2.4 IDE mess as I really need
modular IDE (with piix/via DMA) working. And I need it before the
next Christmas, so waiting for libata doesn't seem to be an option.

HTH.
-- 
Krzysztof Halasa, B*FH
