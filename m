Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbTDGMoA (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTDGMoA (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:44:00 -0400
Received: from ns.suse.de ([213.95.15.193]:7184 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263401AbTDGMn7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 08:43:59 -0400
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
X-Yow: I'm in LOVE with DON KNOTTS!!
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 07 Apr 2003 14:54:41 +0200
In-Reply-To: <Pine.LNX.4.44.0304071422580.12110-100000@serv> (Roman Zippel's
 message of "Mon, 7 Apr 2003 14:31:11 +0200 (CEST)")
Message-ID: <je8yumo4by.fsf@sykes.suse.de>
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) Emacs/21.3.50 (gnu/linux)
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org>
	<b6qruf$elf$1@cesium.transmeta.com> <b6r9cv$jof$1@news.cistron.nl>
	<20030407081800.GA48052@dspnet.fr.eu.org>
	<20030407043555.G13397@devserv.devel.redhat.com>
	<20030407091120.GA50075@dspnet.fr.eu.org>
	<Pine.LNX.4.44.0304071422580.12110-100000@serv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:

|> Hi,
|> 
|> > That breaks one of the main uses, creating with open a temporary file
|> > in /tmp, unlinking it, then later hooking it up somewhere else in the
|> > filesystem.
|> 
|> I wouldn't rely on this functionality, not all filesystems might like it 
|> to have to recreate a deleted fs entry. Most filesystems should be able to 
|> do this, but all fs drivers have to be checked, that they do the right 
|> thing.

All filesystems already have to cope with unlinking of an open file
anyway, so relinking should not be a problem.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
