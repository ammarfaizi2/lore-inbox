Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUCZSLK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbUCZSLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:11:09 -0500
Received: from mail02.hansenet.de ([213.191.73.62]:18075 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S264103AbUCZSKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:10:45 -0500
From: Malte =?iso-8859-1?q?Schr=F6der?= <Malte.Schroeder@hanse.net>
Reply-To: MalteSch@gmx.de
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.4-ck2
Date: Fri, 26 Mar 2004 19:10:11 +0100
User-Agent: KMail/1.6.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200403270252.46873.kernel@kolivas.org>
In-Reply-To: <200403270252.46873.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_KIHZAH/NeH+DcAe";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403261910.18293.Malte.Schroeder@hanse.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_KIHZAH/NeH+DcAe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I was experiencing "skips" in video while playing mpeg4-video with mplayer=
=20
over a DVB-S-card (that means on-the-fly transcoding from mpeg4 to mpeg1) o=
n=20
kernel 2.6.4 with -ck1-patch. I thought it was a problem with mplayer, but =
it=20
went away when I tried -ck2 :)
Nice work.

On Friday 26 March 2004 16:49, Con Kolivas wrote:
> Updated my patchset:
> These are patches designed to improve system responsiveness and add
> features with specific emphasis on the desktop.
>
> http://kernel.kolivas.org
>
> Full feature list:
> am
>  Autoregulates the virtual memory swappiness.
> domains
>  Sched_domains support for better hyperthreading and SMP support including
> my smt nice changes
> stair
>  A complete scheduler policy rewrite for interactivity and responsiveness
> batch
>  Batch scheduling.
> iso
>  Isochronous scheduling.
> cfqioprio
>  Complete Fair Queueing disk scheduler and I/O priorities
> schedioprio
>  Set initial I/O priorities according to cpu scheduling policy and nice
> sng204
>  Supermount-NG v2.0.4
> bs314
>  Bootsplash v3.1.4
> reiser4
>  Reiser4 filesystem
> cddma
>  DMA for cd audio
> grsec
>  Greater security (not included in default patch).
>
>
> Changelog
> Additions:
> + Staircase scheduler - my complete scheduler policy rewrite for
> interactivity built on top of the current O(1) scheduler
> + CD audio DMA
> + Grsec (optional only in experimental dir as it breaks compile if
> disabled)
>
> Changes:
> ~New batch scheduling (idle scheduling) policy from scratch based on new
> scheduler is much simpler and less prone to system starvation issues
> ~New isochronous scheduling (low latency, non real time scheduling for
> non-privileged users)
> ~Updated sched_domains
> ~Updated bootsplash v3.1.4
> ~Updated reiser4 snapshot (2004.03.25)
>
> Unchanged:
> Autoregulated vm swappiness
> Supermount-NG v 2.0.4
> CFQ I/O scheduler with I/O priority support.
>
>
> This is my parting gesture as I'll be on extended leave from 31st March
> till the end of May.
>
> Con
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--Boundary-02=_KIHZAH/NeH+DcAe
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAZHIK4q3E2oMjYtURAhsoAKC305OPAfQY6ji48WI2+DpbIz9uwwCcDDVg
pa0sytRQWTgpnEQrsBN/j/Y=
=yPU7
-----END PGP SIGNATURE-----

--Boundary-02=_KIHZAH/NeH+DcAe--
