Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267210AbSK3DdY>; Fri, 29 Nov 2002 22:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267211AbSK3DdY>; Fri, 29 Nov 2002 22:33:24 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:29569 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S267210AbSK3DdY>; Fri, 29 Nov 2002 22:33:24 -0500
Date: Sat, 30 Nov 2002 14:40:10 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: as-users@afterstep.org, xpert@xfree86.org
Subject: 2.5.x / keyboard goes whacky (linux)
Message-ID: <20021130034010.GC612@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes when I use the windows key with the arrow keys the keyboard
goes whacky and I can nolonger type anything in. It used to be that I
could switch to console and then back to X would fix it but not this
time. This happens when I'm in X, using afterstep as the windowmanager
where I define the left windows key + arrows as pointer movement.

As far as whackyness goes, the capslock key no longer works and it's as
if every keypress generates 2 bytes (as if the kboard went into
unicode).

I looked in dmesg and there's only 1 line of clue:

atkbd.c: Unknown key (set 2, scancode 0x1d0, on isa0060/serio0) pressed.

X version: 4.1.0 (debian 3.0)
afterstep: stable-cvs20020826

Only recourse I have now is a reboot.

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
