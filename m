Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264166AbUDBUhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 15:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264167AbUDBUhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 15:37:19 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:45213 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264166AbUDBUhR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 15:37:17 -0500
To: linux-kernel@vger.kernel.org
Subject: Drivers *dropped* between releases? (sis5513.c)
Mail-Copies-To: never
X-Face: ,MPrV]g0IX5D7rgJol{*%.pQltD?!TFg(`c8(2pkt-F0SLh(g3mIFYU1GYf]C/GuUTbr;cZ5y;3ALK%.OL8A.^.PW14e/,X-B?Nv}2a9\u-j0sSa
From: Roland Mas <roland.mas@free.fr>
Date: Fri, 02 Apr 2004 22:37:12 +0200
Message-ID: <87n05uw1zb.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just got myself a new El Cheapo PC, motherboard is an "ASRock K7S8X".
IDE chipset is SiS746FX.  Tried installing Debian (latest beta3 of the
installer, based on kernel 2.4.25) on it, but I couldn't: the IDE
detection code would load the sis5513 module, then sort of hand for
various amounts of time (during which the loggers complained about
"hda: lost interrupt" and "hdc: lost interrupt").  Eventually, a
timeout would be reached, but the hard drive (hda) woud still not be
usable, and the CD-ROM drive (hdc) wouldn't be usable anymore (after
having been used as a source for loading the modules).

  I've looked around a bit, and it seems that sis5513.c has seen a
change between 2.4.21 and 2.4.22 removing support for the SiS746
chipset.  Well, removing lines mentionint it, at least, but I'm not
enough of a guru to see what it should change.

  So I'm wondering, is this a mistake from my part (which I'll do my
best to solve), from the debian-installer (in which case I'll report
it to them), or has this support really been dropped, in which case
could it please be re-enabled?

  Thanks for any hint,

Roland.
-- 
Roland Mas

C'est dans la boue la plus nauséeuse que plongent les racines de
l'étincelante fleur de lotus. -- in Sri Raoul le petit yogi (Gaudelette)
