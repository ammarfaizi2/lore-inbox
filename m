Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbVKPQH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbVKPQH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbVKPQH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:07:58 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:4234 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1030386AbVKPQH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:07:57 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Johannes Berg <johannes@sipsolutions.net>
Cc: debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: PowerBook5,8 - TrackPad update
Date: Wed, 16 Nov 2005 16:07:39 +0000
Message-Id: <111620051607.26898.437B594B000ACFF200006912220074818400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NextPart_Webmail_9m3u9jl4l_26898_1132157259_0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NextPart_Webmail_9m3u9jl4l_26898_1132157259_0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit


> That's a pure driver function, and we didn't implement it because we
> emulate synaptics. I think your erratically moving thing might be caused
> by a relayout of the order, maybe you should try to observe the
> interrupt transfers the device gives you in a systematic way like I did
> with my python scripts? Those display the levels of each byte. Maybe
> they changed to transmitting not bytes but words for each level?
> 
> johannes
> 

Yep the data layout/ordering is cetainly changed. I was thinking of writing something to relayfs and then use scripts to parse and interpret. But now I think I will be better off using your driver+scripts to sample the data.  

Thanks!

Parag





--NextPart_Webmail_9m3u9jl4l_26898_1132157259_0
Content-Type: message/rfc822

From: Johannes Berg <johannes@sipsolutions.net>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: PowerBook5,8 - TrackPad update
Date: Wed, 16 Nov 2005 15:49:55 +0000
Content-Type: Multipart/mixed;
 boundary="NextPart_Webmail_9m3u9jl4l_26898_1132157259_1"

--NextPart_Webmail_9m3u9jl4l_26898_1132157259_1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iD8DBQBDe1UY/ETPhpq3jKURAlOTAKCP1M1eRU6BniR/knv9qH5xNj9wsQCgoize
WNP0oX6q7dO6jthZ0+XMlkw=
=AOIf
-----END PGP SIGNATURE-----

--NextPart_Webmail_9m3u9jl4l_26898_1132157259_1--

--NextPart_Webmail_9m3u9jl4l_26898_1132157259_0--
