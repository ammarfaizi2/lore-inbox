Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbTGEXRk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 19:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266548AbTGEXRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 19:17:40 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:43707 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S266550AbTGEXPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 19:15:23 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Diego Calleja =?iso-8859-15?q?Garc=EDa?= <diegocg@teleline.es>
Subject: Re: 2.5.74-mm1
Date: Sun, 6 Jul 2003 01:31:02 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <20030703023714.55d13934.akpm@osdl.org> <200307052309.12680.phillips@arcor.de> <20030706001136.3a423b29.diegocg@teleline.es>
In-Reply-To: <20030706001136.3a423b29.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200307060131.02051.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 July 2003 00:11, Diego Calleja García wrote:
> El Sat, 5 Jul 2003 23:09:12 +0200 Daniel Phillips <phillips@arcor.de>
> > The "better" mechanism for sound scheduling is SCHED_RR, which requires
> > root privilege for some reason that isn't clear to me.  Or maybe there
> > once was a good reason, back in the days of the dinosaurs.
>
> I don't think mp3 playing needs nothing special.

It does.  It requires realtime scheduling.  That is special.  Without realtime 
scheduling, the mp3 player will sometimes miss its deadline for filling the 
next chunk of buffer.

> (xmms supports realtime, but you need root)

Needing root in order to play your mp3 without skipping is stupid and 
unnecessary.

Regards,

Daniel

