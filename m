Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132301AbRDPVpB>; Mon, 16 Apr 2001 17:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132316AbRDPVov>; Mon, 16 Apr 2001 17:44:51 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:10075 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S132301AbRDPVof>; Mon, 16 Apr 2001 17:44:35 -0400
Date: Mon, 16 Apr 2001 23:44:20 +0200 (CEST)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: Pavel Machek <pavel@suse.cz>
cc: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <20010416232748.A385@bug.ucw.cz>
Message-Id: <Pine.LNX.4.31.0104162336450.27343-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2001, Pavel Machek wrote:

> > Because we'd be running out of signals soon, when all the other ACPI
> > events get available.

> There are 32 signals, and signals can carry more information, if
> required. I really think doing it way UPS-es are done is right
> approach.

Okay, but at least take a better signal than SIGINT, probably one that the
init maintainers like so it gets adopted faster (or extend SIGPWR).

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

