Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268113AbUJRB20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268113AbUJRB20 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 21:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268141AbUJRB20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 21:28:26 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:13725 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S268113AbUJRB2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 21:28:24 -0400
Date: Mon, 18 Oct 2004 11:28:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Robert Love <rml@novell.com>
Cc: v13@priest.com, ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       akpm@osdl.org, bkonrath@redhat.com, greg@kroah.com
Subject: Re: [RFC][PATCH] inotify 0.14
Message-Id: <20041018112807.3a7edbf7.sfr@canb.auug.org.au>
In-Reply-To: <1098057129.5497.107.camel@localhost>
References: <1097808272.4009.0.camel@vertex>
	<200410180246.27654.v13@priest.com>
	<1098057129.5497.107.camel@localhost>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__18_Oct_2004_11_28_07_+1000_sUCKca8lcYf24kDS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__18_Oct_2004_11_28_07_+1000_sUCKca8lcYf24kDS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 17 Oct 2004 19:52:09 -0400 Robert Love <rml@novell.com> wrote:
>
> It should make dnotify a configuration option, controlled via
> CONFIG_DNOTIFY.

But you have removed the sysctl that allows enabling and disabling of
dnotify at run time.  And you create setattr_mask_dnotify for which I can
find no caller.  And make gratuitous changes to the current dnotify code.
(I point this last out as it just increases the size of the patch for no
purpose.)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__18_Oct_2004_11_28_07_+1000_sUCKca8lcYf24kDS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBcxws4CJfqux9a+8RAl96AJ9PdChSXMMVub6jvPwopHxqd9avBwCfUT5f
BY0BIc/6uxee/21YpoLQEro=
=xkhK
-----END PGP SIGNATURE-----

--Signature=_Mon__18_Oct_2004_11_28_07_+1000_sUCKca8lcYf24kDS--
