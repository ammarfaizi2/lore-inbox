Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbUDRLQm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 07:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264159AbUDRLQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 07:16:42 -0400
Received: from diale198.ppp.lrz-muenchen.de ([129.187.28.198]:32979 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S263464AbUDRLQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 07:16:36 -0400
In-Reply-To: <20040417202223.GA8434@flea>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <pan.2004.04.17.16.44.00.630010@smurf.noris.de> <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea> <A7E7103A-90A1-11D8-833E-000A958E35DC@fhm.edu> <20040417202223.GA8434@flea>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-8-900471362"
Message-Id: <999AB554-9129-11D8-9653-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Daniel Egger <degger@fhm.edu>
Subject: Re: NFS and kernel 2.6.x
Date: Sun, 18 Apr 2004 13:14:46 +0200
To: Marc Singer <elf@buici.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-8-900471362
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 17.04.2004, at 22:22, Marc Singer wrote:

> What I'd like to do is use a command line like this
>
>   root=/dev/nfs ip=rarp nfsroot=,tcp,v3
>
> But, it doesn't work.  I'd like to let the kernel autoconfiguration
> handle the addressing.

According to Documentation/nfsroot.txt you should be able
to do:

root=/dev/nfs ip=rarp nfsroot=/kernel,tcp,v3

i.e. the ip is optional. Just out of curiosity: How would you
supply the kernel name using rarp/bootp/dhcp? Since a few days
I'm using pxelinux but before that I needed to hardcode the
path into the tagged image. Actually I prefer this to restarting
the restarting the dhcp server, but...

Servus,
       Daniel

--Apple-Mail-8-900471362
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQIJjJjBkNMiD99JrAQJgGggAknLLbrHH6Ae4Q7eMPrzx7XogPj3suLGI
PUjkNYn0AKNSrsKjgbQ3Fz7kpCjxBuIW9nBUiTIRuveJsRTZ5pAX0LQE1352jEEK
aTjs4OwavcMZRn9LI3XCJhCpNH9QLQdglSCby/zQF/0RbudcUd4tPBz/ibn7wjRi
bVlUwAjdc7IBX6QZU6F5vohQsN7om6LYj/P2otAk0ap7Im99XWHq/muGCms0wryx
D/tXnZlqpDX8lGrGchuwwp6XPfhzR3zS7rva/PoU6Qzymn2JfAQUJOjqzjW7TS+I
1T/pcCkBzp0Xuw5uitrKmTDWXKfwyGAEXzPseoOyMvS4x5tj7qm0NQ==
=lH6k
-----END PGP SIGNATURE-----

--Apple-Mail-8-900471362--

