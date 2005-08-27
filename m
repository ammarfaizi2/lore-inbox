Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbVH0MHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbVH0MHA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 08:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbVH0MHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 08:07:00 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:46023 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030365AbVH0MG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 08:06:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:bcc:subject:message-id:reply-to:mail-followup-to:mime-version:content-type:content-disposition;
        b=Q4ZH8io1KLwbvE7SXOPHbM4AGrVPdH/4/m9ucZQAAChRhmYVKcp+xvZH9TNmGmPW5e2JoHRYmpe6N6h99OFRqmUhq+VY2X/xysz88AIFWo0iM5QzeQLxyK3gu21GpjiRKfCE1wnRln53OuT3MPZ5wstLxCX65sgpTvYDgARRAXM=
Date: Sat, 27 Aug 2005 14:11:58 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6 context switching and posix threads performance question
Message-ID: <20050827121158.GA18406@oepkgtn.mshome.net>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello List Readers,

I would really appreciate any comment on the overall performance of task
switching with 25 000 threads running on the Linux system. I was asked to w=
ork
on some software which spawns 25 000 threads and I am really worried if
it will ever work on 2 CPU HP Blade. The kernel was modified to support
bigger threads amount running (I have no idea how it was done, probably
just changing hardcoded limits) What is the performance impact of
so much threads on the overall system performance? Is there any ?
Wouldn't it be that such application would spend all of its time
switching contexts ? I'm asking for some kind of an authoritative answer
quite urgently. What is the optimum thread amount on 2 CPU SMP system
running Linux ?


Thank you very much in advance
Mateusz

--=20
  @..@   Mateusz Berezecki=20
 (----)  mateuszb@gmail.com http://mateusz.agrest.org
( >__< ) PGP: 5F1C 86DF 89DB BFE9 899E 8CBE EB60 B7A7 43F9 5808=20
^^ ~~ ^^

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDEFiOKu1H8AtEdBoRAh5cAJwOLGP8cA486qXihyEvCXGSRPSc4wCeKQKB
d35pEQ4KX7pYK9vDVnN4VLs=
=1saT
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

