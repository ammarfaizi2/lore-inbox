Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132072AbRDNMtA>; Sat, 14 Apr 2001 08:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132077AbRDNMsu>; Sat, 14 Apr 2001 08:48:50 -0400
Received: from www.inreko.ee ([195.222.18.2]:52971 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S132072AbRDNMsj>;
	Sat, 14 Apr 2001 08:48:39 -0400
Date: Sat, 14 Apr 2001 15:04:21 +0200
From: Marko Kreen <marko@l-t.ee>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: linux-kernel@vger.kernel.org
Subject: comments on CML 1.1.0
Message-ID: <20010414150421.A28066@l-t.ee>
In-Reply-To: <200104140317.f3E3Hv805992@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104140317.f3E3Hv805992@snark.thyrsus.com>; from esr@snark.thyrsus.com on Fri, Apr 13, 2001 at 11:17:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using CML2 1.1.0 'menuconfig' on clean 2.4.3 (mach is PPro 180)

Suggestions:

* the 'N' should be shown as ' ' as in menuconfig - it is
  visually much better to get overview of whole screenful.
  'Y'/'M' and 'N' are basically of 'same size' so you must look
  directly on letter to understand what it is - not good.

* the menuconfig had nice shortcut: when you pressed 'm' on
  [YN] field, it put 'y' there without questions.  So you could
  use only 2 keys to configure one screen: 'n/m'.  this meant
  you did not need to move fingers around and think about it
  so much - big thing when you are not touch-typer...

* the colors are hard to see (red/blue on black).  Probably
  matter of terminal settings.  I do not have any productive
  ideas tho...  Probably to get best experience to as much
  people as possible the less colors are used the better.
  
  The 'blue: last visited submenu' is unnecessary.  Especially
  because it later turns green...  And the 'red' vs. 'green'
  thing.  I guess the green should be used for 'visited entries'
  too.  Now the red means like 'Doh.  So I should not have
  touched this?'.  Confusing.

  In other words: if there are too much colors, they become
  a thing that should be separately learned, not a helpful
  aid.

  All this IMHO ofcourse.  Colors are 'matter of taste' thing
  so there probably is not exact Rigth Thing.

Bugs/complaints:

* aic7xxx is not updated (defaults: are 8/5 should be 253/5000)
  (this from arch/i386/defconfig maybe?)

* 'IDE chipset support' nesting is very confusing - compare
  to menuconfig.  I would say even 'wrong'...
  (eg. 'PIIXn tuning' is is under 'PIIXn support' which is not
  under 'ATA works in progress'.

* screen is redrawn after _every_ keystroke - not only in moving
  around, but even when you are on input field...

* input field: when there is some default and I start typing it
  should either clear it or append.


-- 
marko

