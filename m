Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbSKCMDu>; Sun, 3 Nov 2002 07:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbSKCMDu>; Sun, 3 Nov 2002 07:03:50 -0500
Received: from pasky.ji.cz ([62.44.12.54]:20207 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261806AbSKCMDs>;
	Sun, 3 Nov 2002 07:03:48 -0500
Date: Sun, 3 Nov 2002 12:13:33 +0100
From: Petr Baudis <pasky@ucw.cz>
To: linux-kernel@vger.kernel.org
Cc: mec@shout.net, zippel@linux-m68k.org
Subject: [kconfig] Survival of scripts/Menuconfig?
Message-ID: <20021103111333.GA2516@pasky.ji.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org, mec@shout.net,
	zippel@linux-m68k.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I'd like to ask if there's still a reason to keep scripts/Menuconfig in the
tree; AFAIK it's not used at all anymore, can we thus remove it? (Possibly we
could mention its existence and basic credits at the top of
scripts/kconfig/mconf.c, which is at least partially based on it?) If the
answer is yes, I'm willing to do the patch etc.

  I'm asking because I want to move the relevant lxdialog functionality to
scripts/kconfig/mconf.c (I think it makes no sense to call lxdialog externally
from mconf.c) and get rid of the separate lxdialog tree. And scripts/Menuconfig
is the only other user of lxdialog.

  Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
