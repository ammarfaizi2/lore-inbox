Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUGFIsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUGFIsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 04:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUGFIsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 04:48:08 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:64431 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S263725AbUGFIsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 04:48:03 -0400
Date: Tue, 6 Jul 2004 10:48:00 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Toshiba keyboard lockups
Message-ID: <20040706084800.GU19374@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <40A162BA.90407@sun.com> <200405121149.37334.rjwysocki@sisk.pl> <40C7880C.4000401@sun.com> <200406101915.i5AJFCBu197611@car.linuxhacker.ru> <efc4b1ba19898906eb0aec7ac9c22fcd@stdbev.com> <40C8DB38.9030300@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40C8DB38.9030300@sun.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fernando Paredes <Fernando.Paredes@Sun.COM>:

> To the benefit of developers, here are the tracebacks for today. I 
> haven't experienced any lockups so far, BUT i have experienced two weird 
> experiences:
> 1) The space key seemed to get stuck and it unstock by pressing <backspace>
> 2) The 'n' key stuck and unstuck itself, displaying about 5 'n' on my 
> screen.

When I added the debugging/callback trace code I got:

Jul  6 09:03:30 hummus2 kernel: serio: RESCAN || RECONNECT requested: 0!
Jul  6 09:03:30 hummus2 kernel: Stack pointer is garbage, not printing trace
Jul  6 09:03:30 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul  6 09:08:49 hummus2 kernel: serio: RESCAN || RECONNECT requested: 0!
Jul  6 09:08:49 hummus2 kernel: Stack pointer is garbage, not printing trace
Jul  6 09:08:49 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul  6 09:08:59 hummus2 kernel: serio: RESCAN || RECONNECT requested: 0!
Jul  6 09:08:59 hummus2 kernel: Stack pointer is garbage, not printing trace
Jul  6 09:08:59 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul  6 09:10:00 hummus2 kernel: serio: RESCAN || RECONNECT requested: 0!
Jul  6 09:10:00 hummus2 kernel: Stack pointer is garbage, not printing trace
Jul  6 09:10:00 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul  6 09:10:24 hummus2 kernel: serio: RESCAN || RECONNECT requested: 0!
Jul  6 09:10:24 hummus2 kernel: Stack pointer is garbage, not printing trace
Jul  6 09:10:24 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul  6 09:10:25 hummus2 kernel: serio: RESCAN || RECONNECT requested: 0!
Jul  6 09:10:25 hummus2 kernel: Stack pointer is garbage, not printing trace
Jul  6 09:10:25 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul  6 09:14:37 hummus2 kernel: serio: RESCAN || RECONNECT requested: 0!
Jul  6 09:14:37 hummus2 kernel: Stack pointer is garbage, not printing trace
Jul  6 09:14:37 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul  6 09:14:55 hummus2 kernel: serio: RESCAN || RECONNECT requested: 0!
Jul  6 09:14:55 hummus2 kernel: Stack pointer is garbage, not printing trace
Jul  6 09:14:55 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul  6 09:18:58 hummus2 kernel: serio: RESCAN || RECONNECT requested: 0!
Jul  6 09:18:58 hummus2 kernel: Stack pointer is garbage, not printing trace
Jul  6 09:18:58 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul  6 09:20:38 hummus2 kernel: serio: RESCAN || RECONNECT requested: 0!
Jul  6 09:20:38 hummus2 kernel: Stack pointer is garbage, not printing trace
Jul  6 09:20:38 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul  6 09:39:31 hummus2 kernel: serio: RESCAN || RECONNECT requested: 0!
Jul  6 09:39:31 hummus2 kernel: Stack pointer is garbage, not printing trace
Jul  6 09:39:31 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul  6 09:58:20 hummus2 kernel: serio: RESCAN || RECONNECT requested: 0!
Jul  6 09:58:20 hummus2 kernel: Stack pointer is garbage, not printing trace
Jul  6 09:58:20 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
