Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265912AbTGIJxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbTGIJxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:53:41 -0400
Received: from mail44-s.fg.online.no ([148.122.161.44]:56739 "EHLO
	mail44.fg.online.no") by vger.kernel.org with ESMTP id S265912AbTGIJxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:53:39 -0400
From: Svein Ove Aas <svein.ove@aas.no>
To: "Clayton Weaver" <cgweav@email.com>, linux-kernel@vger.kernel.org
Subject: Re: PTY DOS vulnerability?
Date: Wed, 9 Jul 2003 12:08:07 +0200
User-Agent: KMail/1.5.2
References: <20030708231157.7322.qmail@email.com>
In-Reply-To: <20030708231157.7322.qmail@email.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307091208.08466.svein.ove@aas.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

onsdag 9. juli 2003, 01:11, skrev Clayton Weaver:
> Seems to me that a pty ulimit and making
> sure that root can always access an unused
> pty on demand are separate issues.
>
> The ulimit is the same issue that it is for
> open files, disk quota, aggregate per-user
> memory utilization, etc, maintaining the
> "multi-user" aspect of system usability.
>
> Making sure that root has the tools to do
> what is needed in a pty resource exhaustion
> situation deserves perhaps a different
> mechanism, like dynamic, on-demand pty device
> creation for root (which seems to me more
> robust than a "reserved for root" mechanism,
> which allows the possibility that root
> processes have already used up that many
> ptys when root needs one in an emergency).

But if you're going to do that for root, then why not do it for all users?
That would avoid the problem altogether, after all...

- - Svein Ove Aas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/C+mH9OlFkai3rMARAvlIAKCuBSdCx31kgcMP8hFaEx3qkdWiZwCfUI0A
YSDkrEFpFnmIkzXUi1E7Tnw=
=Hmkz
-----END PGP SIGNATURE-----

