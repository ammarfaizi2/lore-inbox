Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQKMQfL>; Mon, 13 Nov 2000 11:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQKMQfC>; Mon, 13 Nov 2000 11:35:02 -0500
Received: from hsregn1-22.sk.sympatico.ca ([142.165.128.22]:46353 "HELO
	bruce-guenter.dyndns.org") by vger.kernel.org with SMTP
	id <S129060AbQKMQer>; Mon, 13 Nov 2000 11:34:47 -0500
Date: Mon, 13 Nov 2000 10:34:44 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Wild thangs, was: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Message-ID: <20001113103444.A6392@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A0C427A.E015E58A@timpanogas.org> <20001110095227.A15010@sendmail.com> <3A0C37FF.23D7B69@timpanogas.org> <20001110101138.A15087@sendmail.com> <3A0C3F30.F5EB076E@timpanogas.org> <20001110133431.A16169@sendmail.com> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <3A0C929B.EE6F7137@linux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A0C929B.EE6F7137@linux.com>; from david@linux.com on Fri, Nov 10, 2000 at 04:28:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2000 at 04:28:11PM -0800, David Ford wrote:
> Some wild blatherings about sendmail...

Warning:  the following will likely be seen by some as flamebait.  I've
long ago divorced myself from sendmail to save my own sanity.

> - Uses lots of memory to send a big file.
>     Incorrect.  I just verified it with a 10 meg file which became a 14 m=
eg attachment.
> Sendmail consumed an additional 5 megs combined while handling the input =
and output v.s.
> an idle daemon.  Idle is 1.8M, recv was 4.0M, send was 2.3M, no measure o=
n the remote
> side.  I sent it via pine to a remote address.

As opposed to modern mail servers which can send messages of any size
using constant sized small (well under 1M) processes.

> - Requires high load average allowance
>     Incorrect.  Same machine barely spiked a tenth of a point for this lo=
ad and dropped
> back to .05.

You saw load while sending a single file?  Modern mail servers can send
without generating significant load (unless your server was a 386).
I've used older Pentium boxes that could send 60 messages at a time
without hitting .1 load.

Anyways, this is rather off topic for linux-kernel.
--=20
Bruce Guenter <bruceg@em.ca>                       http://em.ca/~bruceg/

--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6EBgk6W+y3GmZgOgRAha7AJwIyKiuggWmgew5YLcYNMN5iyxnPQCeILbd
kvKPGkngbUGxWakzfV04sHw=
=Fr0z
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
