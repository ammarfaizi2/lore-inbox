Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266395AbUFZUMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266395AbUFZUMl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 16:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUFZUMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 16:12:40 -0400
Received: from mout0.freenet.de ([194.97.50.131]:50116 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S266395AbUFZUMe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 16:12:34 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Wes Janzen <superchkn@sbcglobal.net>
Subject: Re: [PATCH] Staircase scheduler v7.4
Date: Sat, 26 Jun 2004 22:11:16 +0200
User-Agent: KMail/1.6.2
References: <40DC38D0.9070905@kolivas.org> <40DDD6CC.7000201@sbcglobal.net>
In-Reply-To: <40DDD6CC.7000201@sbcglobal.net>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Pauli Virtanen <pauli.virtanen@hut.fi>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406262211.24373.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 26 June 2004 22:04, you wrote:
> Hi Con,
> 
> I don't know what's going on but 2.6.7-mm2 with the staircase v7.4 (with 
> or without staircase7.4-1) takes about 3 hours to get from loading the 
> kernel from grub to the login prompt.  Now I realize my K6-2 400 isn't 
> state of the art...  I don't have this problem running 2.6.7-mm2.
> 
> It just pauses after starting nearly every service for an extended 
> period of time.  It responds to sys-rq keys but just seems to be doing 
> nothing while waiting.
> 
> Any suggestions?

Maybe same problem as mine?
Some init-scripts don't get their timeslices?

> Thanks,
> 
> Wes Janzen

(Oh, please don't quote whole patches in future, if you don't
comment on them, Wes. Thanks.)

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3dhpFGK1OIvVOP4RArqcAJ9xtGOUwyP2QJIXzZjZQxNlCxDp0gCfYIbl
XQtqxR5OT4ZE5BVMdvqzF/E=
=qDl9
-----END PGP SIGNATURE-----
