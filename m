Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWI1HEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWI1HEQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 03:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWI1HEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 03:04:16 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:46284 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751649AbWI1HEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 03:04:14 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Date: Thu, 28 Sep 2006 09:04:57 +0200
User-Agent: KMail/1.9.4
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200609271424.47824.eike-kernel@sf-tec.de> <p73k63pje1w.fsf@verdi.suse.de>
In-Reply-To: <p73k63pje1w.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2076128.VkdI0OZa2Q";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609280904.57941.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2076128.VkdI0OZa2Q
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 27. September 2006 21:38 schrieb Andi Kleen:
> Rolf Eike Beer <eike-kernel@sf-tec.de> writes:
> > I get this on my machine. SMP kernel, linus git from this morning.
> > .config and test available on request.
>
> What gcc do you use?

4.1.0 (SuSE 10.1)

> Anyways, does this patch fix it? This might have been Andrew's vaio probl=
em
> too.

Looks good, now it hangs because the init skript seems to have problems=20
activating the root volume group. But that's a different story.

Eike

--nextPart2076128.VkdI0OZa2Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFG3QZXKSJPmm5/E4RAjGqAJ9aYx5qaUFZANYaJ3NggqWR6Hv4aQCfVels
E1dQ9M7lG9TOvMKUwmt3xYg=
=09zf
-----END PGP SIGNATURE-----

--nextPart2076128.VkdI0OZa2Q--
