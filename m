Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132986AbRDKUXl>; Wed, 11 Apr 2001 16:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132989AbRDKUXV>; Wed, 11 Apr 2001 16:23:21 -0400
Received: from schiele.swm.uni-mannheim.de ([134.155.20.124]:54659 "EHLO
	schiele.swm.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S132986AbRDKUXO>; Wed, 11 Apr 2001 16:23:14 -0400
Date: Wed, 11 Apr 2001 22:22:50 +0200
From: Robert Schiele <rschiele@uni-mannheim.de>
To: Daniel.Stutz@astaro.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where is NR_TASKS gone in 2.4?
Message-ID: <20010411222250.A10215@schiele.local>
In-Reply-To: <20010409172419.H430@mukmin.astaro.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010409172419.H430@mukmin.astaro.de>; from dstutz@astaro.de on Mon, Apr 09, 2001 at 05:24:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2001 at 05:24:19PM -0700, Daniel Stutz wrote:
> How can i get the max. number of tasks in kernel 2.4?
>=20
> In 2.2 there was a macro NR_TASKS

2.4 has no hardcoded limit on the number of processes. So NR_TASKS is
not necessary any longer.
But you can read the current value of max threads from
/proc/sys/kernel/threads-max.

Robert

--=20
Robert Schiele			mailto:rschiele@uni-mannheim.de
Tel./Fax: +49-621-10059		http://webrum.uni-mannheim.de/math/rschiele/

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEVAwUBOtS9GcQAnns5HcHpAQER1Af/fO3BYSI+jG3m4JCMvZhLte1gTjBqR4vq
SafLjnpdvFRVIZYb1usGGr7Bye1UgYeSVYt6KIMHaP5bFcejukQbW8wQIng4Op+K
MIEO16DD44nM91hFDvYMxj+CvmKzP+LdB2TD2VAtNqJYc/d4NPD20lF0JmlhIwHN
mUwIkgmoGgXZtk36vLUIGUe+3jRTk2HIsybi6cBO3qIIDbvAPlb+4x/2nL1ZF7Yp
ELg7JLyYmLq5TbqTHA45HKyBh5UHnq/RLQP/1Mv4ktW1vClTo5usAVhZIeGdo09Z
Txg0OW+QhNwqsmQafAWoNqdpsO2YaqRWskiK1iQRwwvKBIkc6oNw6Q==
=DBgg
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
