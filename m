Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266126AbUFWGkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUFWGkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 02:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUFWGkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 02:40:45 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:56062 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S266126AbUFWGkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 02:40:39 -0400
Date: Wed, 23 Jun 2004 02:34:35 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Paul Jakma <paul@clubi.ie>, <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix sata_sil quirk
In-Reply-To: <40D8FE55.3030008@pobox.com>
Message-ID: <Pine.GSO.4.33.0406230230010.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004, Jeff Garzik wrote:
>Nope, my patch only enables ATA_DFLAG_LOCK_SECTORS for devices flagged
>with SIL_QUIRK_MOD15WRITE:
...

That list needs a:
         { "ST3160023AS",        SIL_QUIRK_MOD15WRITE },
as well.

--Ricky

PS: I've completed 23 cycles of zeroing a 40G section of RAID0 space without
    error.


