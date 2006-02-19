Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWBSBo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWBSBo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 20:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWBSBo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 20:44:28 -0500
Received: from util105.his.com ([216.194.192.8]:35040 "EHLO util105.his.com")
	by vger.kernel.org with ESMTP id S964804AbWBSBo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 20:44:28 -0500
Date: Sat, 18 Feb 2006 20:43:56 -0500 (EST)
From: Thomas Dickey <dickey@his.com>
To: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>, torvalds@osdl.org,
       bug-ncurses@gnu.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
In-Reply-To: <43F7310E.4070109@pg.gda.pl>
Message-ID: <20060218204040.B36972@mail101.his.com>
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <43F72A1E.1090707@ums.usu.ru>
 <43F7310E.4070109@pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-730877046-1140313436=:36972"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-730877046-1140313436=:36972
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 18 Feb 2006, Adam Tla=C5~Bka wrote:

> Hmm, I don't know how current ncurses treat terminfo definition in UTF-8 =
mode=20
> and what linux terminal definition you are using in you test system. Ther=
e=20
> are different definitions floating around in different distributions whic=
h

Since we're talking about ncurses, there are not "different definitions=20
floating around".  Different distributions may of course have their=20
favorite tweaks, but ncurses definition for Linux console doesn't change
that much over the past ten years.

> are slightly different especially as we talk about acsc chars and enacs,=
=20
> smacs and rmacs sequences. Which is also wrong approach so there should b=
e=20
> one proper definition of the linux console. Maybe kernel developers shoul=
d=20
> prepare some most compatible and acceptable one.
> I can post the one I am using today:

=2E..of course, this one isn't like any of the variations I've seen.
But you knew that.  (Aside from the acs/enacs/rmacs/smacs changes,
I'm curious what happened to ich/ich1).

--=20
Thomas E. Dickey
http://invisible-island.net
ftp://invisible-island.net
--0-730877046-1140313436=:36972--
