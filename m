Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQJ3TMn>; Mon, 30 Oct 2000 14:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129026AbQJ3TMc>; Mon, 30 Oct 2000 14:12:32 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:43869 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129032AbQJ3TMT>; Mon, 30 Oct 2000 14:12:19 -0500
Date: Mon, 30 Oct 2000 19:12:13 +0000
From: Tim Waugh <twaugh@redhat.com>
To: rread@datarithm.net
Cc: Brett Smith <brett.smith@bktech.com>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: installing an ISR from user code
Message-ID: <20001030191213.V16849@redhat.com>
In-Reply-To: <39FDAE74.2AED0C74@bktech.com> <20001030110659.A26335@datarithm.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="xku3GkZTJumTa1rO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001030110659.A26335@datarithm.net>; from rread@datarithm.net on Mon, Oct 30, 2000 at 11:06:59AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xku3GkZTJumTa1rO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 30, 2000 at 11:06:59AM -0800, rread@datarithm.net wrote:

> I'm new at this myself, but how about creating a minor number for each
> ISR?  When the BH runs, it wakes up the processing waiting on the
> device for that ISR.

... which won't get run until after the interrupt is processed, but
the interrupt won't get processed until it's run.  Nope.

Tim.
*/

--xku3GkZTJumTa1rO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE5/cgMONXnILZ4yVIRAuQxAJ9fyg1TyYVkwCj7hyu/yjIROXobbACdHkqC
JsRp5FYz/9ZJ4jZ4Ox2yTxU=
=YFal
-----END PGP SIGNATURE-----

--xku3GkZTJumTa1rO--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
