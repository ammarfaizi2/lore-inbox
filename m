Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUGMATs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUGMATs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUGMATq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:19:46 -0400
Received: from mail022.syd.optusnet.com.au ([211.29.132.100]:9873 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264305AbUGMASh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:18:37 -0400
References: <200407122354.i6CNsNqS003382@localhost.localdomain>
Message-ID: <cone.1089677888.268686.12958.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       florin@sgi.com
Subject: Re: desktop and multimedia as an afterthought?
Date: Tue, 13 Jul 2004 10:18:08 +1000
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-12958-1089677888-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-12958-1089677888-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Paul Davis writes:

>>It's too bad that the multimedia community didn't participate
>>much during the 2.5.xx development leading up to 2.6.0. If they
>>had done so, the situation might be different today. Fortunately,
>>fixing up the multimedia problems isn't too risky to do during
>>the stable 2.6.xx series.
> 
> I regret that this description is persisting here. "We" (the audio
> developer community) did not participate because it was made clear
> that our needs were not going to be considered. We were told that the
> preemption patch was sufficient to provide "low latency", and that
> rescheduling points dotted all over the place was bad engineering
> (probably true). With this as the pre-rendered verdict, there's not a
> lot of point in dedicating time to tracking a situation that clearly
> is not going to work.
> 
> The kernel is not going to provide adequate latency for multimedia
> needs without either (1) latency issues being front and center in
> every kernel developer's mind, which seems unlikely and/or (2)
> conditional rescheduling points added to the kernel, which appears to
> require non-mainstreamed patches.

Please dont start a low level flamewar over this. Latency is firmly on the 
agenda and under consideration for the mainline kernel now. 

There is nothing wrong with using a dedicated alternative patchset for 
specific tasks, as long as any lessons learnt from it are also taken into 
consideration for mainline. Mainline kernels must have (high gain)/(low 
risk) ratio changes only. 

Rather than just saying that the desktop and multimedia is not considered it 
would be more helpful to say what helps where and why in the public forum of 
the main kernel mailing list. Off list discussion can go completely 
unnoticed (even I wasn't aware of my patchset being used and quoted!)

Cheers,
Con


--=_mimegpg-pc.kolivas.org-12958-1089677888-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8ypAZUg7+tp6mRURAlM7AJ0QCA8PVlfo4Uyb2RjZHlaHqfNFtACfe7yq
cRQZJTp5Kk4tEVdl4Dd4bFs=
=Ndbr
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-12958-1089677888-0001--
