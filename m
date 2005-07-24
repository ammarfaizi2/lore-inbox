Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVGXB4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVGXB4b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 21:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVGXB4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 21:56:30 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:5901 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261594AbVGXB42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 21:56:28 -0400
Date: Sun, 24 Jul 2005 09:48:25 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Oliver Neukum <oliver@neukum.org>
cc: Lasse =?utf-8?q?K=C3=A4rkk=C3=A4inen_/_Tronic?= 
	<tronic+lzID=lx43caky45@trn.iki.fi>,
       ioGL64NX <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Supermount
In-Reply-To: <200507231247.17034.oliver@neukum.org>
Message-ID: <Pine.LNX.4.63.0507240945030.2284@donald.themaw.net>
References: <42E00DD3.9060407@trn.iki.fi> <2de37a440507211450501a8378@mail.gmail.com>
 <42E12105.3090900@trn.iki.fi> <200507231247.17034.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1629620785-427652843-1122169705=:2284"
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-101.4, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, RCVD_IN_ORBS,
	RCVD_IN_OSIRUSOFT_COM, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1629620785-427652843-1122169705=:2284
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 23 Jul 2005, Oliver Neukum wrote:

> Am Freitag, 22. Juli 2005 18:38 schrieb Lasse K=C3=A4rkk=C3=A4inen / Tron=
ic:
> > > Supermount is obsolete there are other tools in userspace that do the
> > > job perfectly.
> > > e.g ivman which uses hal and dbus.
> >=20
> > They cannot mount on demand, thus cannot do the same job. The boot
> > partition, for example, is something that should only be mounted when
> > required. The same obviously also goes for network filesystems in many
> > cases (i.e. avoid having zillion idling connections to the server).
>=20
> To mount on demand use autofs. Unmounting and dealing with media removal
> is the problem.

That's not the only problem.
We can't do owner mounts of the floppy, for example.
smb mounts have similar problems in needing to identify the requester in=20
order to get authentication info.

But that's on the agenda to be fixed.

Ian

--1629620785-427652843-1122169705=:2284--
