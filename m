Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTK0JOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 04:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264462AbTK0JOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 04:14:46 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:37866 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S264461AbTK0JOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 04:14:45 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Albert Cahalan <albert@users.sf.net>
Subject: Re: Never mind. Re: Signal left blocked after signal handler.
Date: Thu, 27 Nov 2003 10:11:51 +0100
User-Agent: KMail/1.5.4
Cc: bruce@perens.com, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1069883580.723.416.camel@cube>
In-Reply-To: <1069883580.723.416.camel@cube>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311271012.07893.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 26 November 2003 22:53, Albert Cahalan wrote:
[2.4 vs. 2.6 wrt. thread synchronous signals]
> How about making the process sleep in a killable state?
>
> This is as if the blocking was obeyed, but doesn't
> burn CPU time. Only a debugger should be able to
> tell the difference.

This has 2 problems:

1) Servers and PID files or servers and simple monitoring software.
2) Processes spawned from init, which will not respawn.

Regards


Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/xb/mU56oYWuOrkARAmNaAKCL1uojbOpMtMdSvAl6B9rBW51CTgCgypP8
NlbaIac25oefxcHL9WlzxyE=
=h6UI
-----END PGP SIGNATURE-----

