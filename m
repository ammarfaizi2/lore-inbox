Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271901AbTGYDer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 23:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271903AbTGYDer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 23:34:47 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:2262 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S271901AbTGYDeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 23:34:46 -0400
Date: Thu, 24 Jul 2003 23:49:40 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: Net device byte statistics
In-reply-to: <E19ftDj-00016j-00@calista.inka.de>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Message-id: <200307242349.48394.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <E19ftDj-00016j-00@calista.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 24 July 2003 23:26, Bernd Eckenfels wrote:
> In article <200307250437.50928.fredrik@dolda2000.cjb.net> you wrote:
> > I almost thought that would be it. I do understand that that code needs
> > to be really clean, but, correct me if I'm wrong, but isn't GCC's long
> > long implementation efficient enough to only add minimal overhead to
> > that?
>
> I think there is mainly an issue with atomic incremets. I am not sure if
> the counter can be incremeted concurrently, or if the code path would be
> serialized, but there is always the reading side, which may need to retry
> an read. Besides that, the counter is in the fast path, so it will add some
> delay to packet handling.
>
> I guess a 64bit implementation will need to be a per-cpu solution.

I am actually working on it.

Jeff.

- -- 
You measure democracy by the freedom it gives its dissidents, not the
freedom it gives its assimilated conformists.
		- Abbie Hoffman
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IKjYwFP0+seVj/4RAi30AKCKSue0MzoXXggx0BJriERW5DXpIQCg1ECY
ZDgy8Dra96jzj4zJz/pGAW0=
=wuhA
-----END PGP SIGNATURE-----

