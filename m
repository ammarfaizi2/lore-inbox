Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWGQKwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWGQKwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 06:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWGQKwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 06:52:44 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:45447 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750723AbWGQKwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 06:52:44 -0400
Date: Mon, 17 Jul 2006 12:52:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Uwe Bugla <uwe.bugla@gmx.de>
cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, akpm@osdl.org,
       johnstul@us.ibm.com
Subject: Re: i686 hang on boot in userspace
In-Reply-To: <20060714150418.120680@gmx.net>
Message-ID: <Pine.LNX.4.64.0607171242440.6761@scrub.home>
References: <20060714150418.120680@gmx.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-1857953486-1153133548=:6761"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-1857953486-1153133548=:6761
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 14 Jul 2006, Uwe Bugla wrote:

> Hi everybody,
> first of all thanks to the explanatory hints how a magic Sysrq key works =
=E2=80=93 I've learned a lot.
>=20
> I first pressed ALT + PrintScreen + P, then ALT + PrintScreen + T.
> To avoid wordwrapping or other unwanted effects please see the resulting =
kern.log as outline attachment.
>=20
> Could someone please explain to me what's behind that cryptic code?

It shows what the kernel is currently is doing and where it's spending the=
=20
time.
First, your kernel buffer log buffer seems a little small, so not=20
everything is captured. Could you increase the number in the "Kernel log=20
buffer size" option (it's in the "Kernel debugging" part of the "Kernel=20
hacking" menu).
Second, could you press ALT+PrintScreen+P a few more times (maybe around=20
10 at least) while the kernel hangs? This would should where the cpu is=20
spending its time and whether it's at a single place or at different=20
places.
Thanks.

bye, Roman
---1463811837-1857953486-1153133548=:6761--
