Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278142AbRJRUrT>; Thu, 18 Oct 2001 16:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278139AbRJRUrK>; Thu, 18 Oct 2001 16:47:10 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:10269 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S278136AbRJRUrC>; Thu, 18 Oct 2001 16:47:02 -0400
Date: Thu, 18 Oct 2001 15:47:09 -0500
From: Tim Walberg <twalberg@mindspring.com>
To: James Sutherland <jas88@cam.ac.uk>, Ben Greear <greearb@candelatech.com>,
        Neil Brown <neilb@cse.unsw.edu.au>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
Message-ID: <20011018154709.E29662@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	James Sutherland <jas88@cam.ac.uk>,
	Ben Greear <greearb@candelatech.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BCE6E6E.3DD3C2D6@candelatech.com> <Pine.SOL.4.33.0110180937420.13081-100000@yellow.csi.cam.ac.uk> <20011018132035.A444@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011018132035.A444@mikef-linux.matchmail.com> from Mike Fedyk on 10/18/2001 15:20
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A semi-random thought on the tree-quota concept:

Does it really make sense to charge a tree quota to a single specific
user? I haven't really looked into what would be required to implement
it, but my mental picture of a tree quota is somewhat divorced from the
user concept, other than maybe the quota table containing a pointer to
a contact for quota violations. The bookkeeping might be easier if each
tree quota root just held a cumulative total of allocated space, and
maybe a just a user name for contacts (or on the fancier side, a hook
to execute something...).

I know it's kinda half-baked, but that's my $0.015...

				tw

On 10/18/2001 13:20 -0700, Mike Fedyk wrote:
>>	Actually, it looks like Niel is creating a two level Quota system.  In t=
her
>>	normal quota system, if you own a file anywhere, it is attributed to you.
>>	But, in the tree quota system, it is attributed to the owner of the tree=
...
>>=09
>>	Niel, how do you plan to notify someone that their tree quota has been
>>	exceeded instead of their normal quota?
>>	-
>>	To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>>	the body of a message to majordomo@vger.kernel.org
>>	More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>	Please read the FAQ at  http://www.tux.org/lkml/
End of included message



--=20
twalberg@mindspring.com

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO88/y8PlnI9tqyVmEQIbygCfSW7+uWO8NYm5fcWFm3+fxnFsQIoAnjG8
ZztEyYAUsJX4hXaFAlNEANIe
=puSv
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
