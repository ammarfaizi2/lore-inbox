Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUKTUMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUKTUMW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 15:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUKTUMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 15:12:22 -0500
Received: from penguin.ucs.ed.ac.uk ([129.215.70.82]:11404 "EHLO
	penguin.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S263167AbUKTUMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 15:12:18 -0500
To: Jin Suh <jinssuh@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.28] Enabling a SATA drive (sata_promise.o) with Promise Fastrak S150 TX2Plus SATA PCI card?
References: <20041119200331.53569.qmail@web41210.mail.yahoo.com>
From: Kenneth MacDonald <kenny@holyrood.ed.ac.uk>
Date: 20 Nov 2004 20:12:07 +0000
In-Reply-To: <20041119200331.53569.qmail@web41210.mail.yahoo.com>
Message-ID: <yqo7jog46w8.fsf@penguin.ucs.ed.ac.uk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jin" == Jin Suh <jinssuh@yahoo.com> writes:

    Jin> Hello, I have a Dell 650/Linux-2.4.28 with a Promise Fastrak
    Jin> S150 TX2Plus SATA PCI card with 2 250GB Western digital
    Jin> drives connected. Could anyone help me how to enable the SATA
    Jin> drives? I had 2.4.25 one time and it showed me /dev/hde and
    Jin> /dev/hdg but the new SATA driver should show as /dev/sdX,
    Jin> right?

    Jin> I see libata.o and sata_promise.o modules. When I do
    Jin> "modprobe libata and modprobe sata_promise", I got bunch of
    Jin> "Unresolved symbols". I also downloaded ft3xx driver and
    Jin> didn't work too. Any idea? I rebooted the same machine with
    Jin> Suse9.1 (2.6.x kernel). It loaded the libata.o and
    Jin> sata_promise.o and I could see /dev/sda and /dev/sdb as SATA
    Jin> drives correctly.  I also have a Intel P5 ICH5, D875PBZ with
    Jin> 2 SATA ports. I also could not enable the drives with
    Jin> ata_piix.o. Any helps would be appreciated.

I had this problem when I was using an insmod from busybox compiled up
without the tainted kernel checking feature.  the libata.o module is a
GPLONLY as far as I recall.

So, check your insmod/modprobe versions.

Kenny.

-- 
Desktop Services Team, EUCS.

University of Edinburgh, Scotland.
