Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWCWIC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWCWIC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWCWIC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:02:28 -0500
Received: from altrade.nijmegen.internl.net ([217.149.192.18]:38596 "EHLO
	altrade.nijmegen.internl.net") by vger.kernel.org with ESMTP
	id S1030194AbWCWIC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:02:27 -0500
From: jos poortvliet <jos@mijnkamer.nl>
To: ck@vds.kolivas.org
Subject: Re: [ck] swap prefetching merge plans
Date: Thu, 23 Mar 2006 09:01:53 +0100
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060322205305.0604f49b.akpm@osdl.org> <200603231804.36334.kernel@kolivas.org>
In-Reply-To: <200603231804.36334.kernel@kolivas.org>
X-Face: $0>4o"Xx2u2q(Tx!D+6~yPc{ZhEfnQnu:/nthh%Kr%f$aiATk$xjx^X4admsd*)=?utf-8?q?IZz=3A=5FkT=0A=09=7CurITP!=2E?=)L`*)Vw@4\@6>#r;3xSPW`,~C9vb`W/s]}Gq]b!o_/+(lJ:b)=?utf-8?q?T0=26KCLMGvG=7CS=5E=0A=09z=7B=5C=2E7EtehxhFQE=27eYSsir/=7CtQ?=
 =?utf-8?q?j=23rWQe4o?=>WC>_R<vO,d]czmqWYkq[v~iB.e_GuxB'")
 =?utf-8?q?p3=0A=09jGdrhlY4=5E!vd=3F=3AegW?=)xn&fP4!FV<.
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1932686.VRHgXILVRu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603230901.57052.jos@mijnkamer.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1932686.VRHgXILVRu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op donderdag 23 maart 2006 08:04, schreef Con Kolivas:
> On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
> > A look at the -mm lineup for 2.6.17:
> >
> > mm-implement-swap-prefetching.patch
> > mm-implement-swap-prefetching-fix.patch
> > mm-implement-swap-prefetching-tweaks.patch
> >
> >   Still don't have a compelling argument for this, IMO.

well, the reason i use it is my computer is much more reactive in the morni=
ng.=20
linux uses to get very slow after a night of not-doing-much except some=20
'sleep 5h && blabla' and cron stuff. in the morning it takes a few HOURS to=
=20
get up and running smoothly. with swap prefetch, it actually feels faster=20
compared to a fresh boot. now you can force swap prefetch to start working,=
 i=20
use it now and then after some heavy taskts which pulled everything to swap.

> For those users who feel they do have a compelling argument for it, please
> speak now or I'll end up maintaining this in -ck only forever.  I've come
> to depend on it with my workloads now so I'm never dropping it. There's no
> point me explaining how it is useful yet again, though, because I just end
> up looking like I'm handwaving. It seems a shame for it not to be availab=
le
> to all linux users.
>
> Cheers,
> Con
> _______________________________________________
> http://ck.kolivas.org/faqs/replying-to-mailing-list.txt
> ck mailing list - mailto: ck@vds.kolivas.org
> http://vds.kolivas.org/mailman/listinfo/ck

=2D-=20
You will gain money by a fattening action.

--nextPart1932686.VRHgXILVRu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEIlX1+wgQ1AD35iwRArtqAKDQX5JV1yZvop64w1mvPJy7pAvF3ACfTSZr
v2W2r8ndSrHfPQZxsoJH6dI=
=zF0t
-----END PGP SIGNATURE-----

--nextPart1932686.VRHgXILVRu--
