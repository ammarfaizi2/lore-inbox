Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133003AbRAJBpG>; Tue, 9 Jan 2001 20:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133001AbRAJBpB>; Tue, 9 Jan 2001 20:45:01 -0500
Received: from firebox-ext.surrey.redhat.com ([194.201.25.236]:11258 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S130575AbRAJBoq>; Tue, 9 Jan 2001 20:44:46 -0500
Date: Wed, 10 Jan 2001 01:44:37 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: SCSI scanner problem with all kernels since 2.3.42
Message-ID: <20010110014437.D1582@redhat.com>
In-Reply-To: <3A5B7A2E.E3F964A8@torque.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5B7A2E.E3F964A8@torque.net>; from dougg@torque.net on Tue, Jan 09, 2001 at 03:53:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2001 at 03:53:02PM -0500, Douglas Gilbert wrote:

> by timeouts ** resulting in scsi bus resets. Anyway the problem
> seems to disappear with the recently released SANE 1.0.4 .
> [The original report was based on SANE 1.0.3 and earlier.]

In fact my report that the problem went away was wrong. :-(

> ** SANE's newer sg interface shortens the per command timeout
> from 10 minutes to 10 seconds. Most other OSes interfaces in
> SANE have a timeout value of 1 minute or more. I suspect 10=20
> seconds may be too short.

Increasing the timeout fixed the problem.

Thanks,
Tim.
*/

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6W76EONXnILZ4yVIRAgQSAJ4hz/ceQ4GN1U6jLoSa0Tk5PnEwXQCfbgQ2
yA/MBVaxc4MeLnhacmk3cSc=
=PLgV
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
