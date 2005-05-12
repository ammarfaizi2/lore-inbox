Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVELMRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVELMRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVELMRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:17:52 -0400
Received: from relay.snowman.net ([66.92.160.56]:46087 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id S261557AbVELMRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:17:46 -0400
Date: Thu, 12 May 2005 08:18:05 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Andrew Morton <akpm@osdl.org>, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipt_recent fixes
Message-ID: <20050512121805.GX30011@ns.snowman.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <87ll6o1pbi.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CpBQqYjq/d0HQTAP"
Content-Disposition: inline
In-Reply-To: <87ll6o1pbi.fsf@blackdown.de>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 08:12:55 up 467 days,  7:02, 29 users,  load average: 4.45, 4.44, 4.27
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CpBQqYjq/d0HQTAP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Juergen Kreileder (jk@blackdown.de) wrote:
> This patch fixes the problem by using get_seconds() instead of
> jiffies.  It also fixes some 64-bit issues.

This looks alright to me, provided get_seconds() doesn't mind being
called under the locks being held by ipt_recent at that time.  Of
course, it also needs to be fast.

	Thanks,

		Stephen

--CpBQqYjq/d0HQTAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCg0l8rzgMPqB3kigRAizAAKCTRFixgFj1no/GclFQnnMYbdSmBACfeyVA
i1cei7MtFKY8GaqgKoeHzoA=
=2jUz
-----END PGP SIGNATURE-----

--CpBQqYjq/d0HQTAP--
