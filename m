Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWILTjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWILTjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWILTjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:39:24 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:2228 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S1030382AbWILTjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:39:23 -0400
Date: Tue, 12 Sep 2006 15:39:18 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC] OLPC tablet input driver, take three.
Message-ID: <20060912193918.GE4187@aehallh.com>
Mail-Followup-To: Dmitry Torokhov <dtor@insightbb.com>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>
References: <20060829073339.GA4181@aehallh.com> <20060910201036.GD4187@aehallh.com> <20060911190225.GS4181@aehallh.com> <d120d5000609111210ud9ea310y40675db6e5edbed@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <d120d5000609111210ud9ea310y40675db6e5edbed@mail.gmail.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 11, 2006 at 03:10:06PM -0400, Dmitry Torokhov wrote:
> On 9/11/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> >
> >4: Technical: I've not implemented the KCONFIG option for this driver
> >yet, it's on my todo list, but for after we get the sample rate stuff
> >figured out.
> >
> >
> >That said, here the patch, it seems to work, and it's time to at least
> >get into the OLPC kernel tree, if not mainline.
> >
> 
> Zephaniah,
> 
> What are the chances that commodity hardware will have OLPC device
> present? If there are none (or extremely slim) I think we'd better
> wait for Kconfig option to be implemented before adding this to
> mainline because psmouse is already too fat.

Extremely slim, the current generation of samples are 3.3V units instead
of 5V units.

When I go in and do this, would it make sense to split out most of the
external to psmouse-base.c drivers to be options, most tied to being on
unless CONFIG_EMBEDDED is enabled?

Zephaniah E. Hull.
> 
> Otherwise it looks good.
> 
> -- 
> Dmitry
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

"I would rather spend 10 hours reading someone else's source code than
10 minutes listening to Musak waiting for technical support which
isn't."
(By Dr. Greg Wettstein, Roger Maris Cancer Center)

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFBwzmRFMAi+ZaeAERAkYbAJ9G8M9AxCzMP2AX4vk99UCQVzxBzQCeJoZN
Zv3EoABpzl9LiniO/OlEjXw=
=/cLL
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
