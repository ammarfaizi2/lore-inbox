Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbVHVW1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbVHVW1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVHVW0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:26:51 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17289 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751375AbVHVW0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:26:13 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes. Also some X trouble.
Date: Mon, 22 Aug 2005 10:01:30 +0200
User-Agent: KMail/1.8.2
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <42F89F79.1060103@aitel.hist.no> <200508171326.21948@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508171326.21948@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart19745969.NGhCgWe2R8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508221001.39050@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart19745969.NGhCgWe2R8
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>Helge Hafting wrote:
>>Dave Airlie wrote:
>>>     I switched back to 2.6.13-rc4-mm1 at this point for another reason,
>>>     my X display aquired a nasty tendency to go blank for no reason
>>>     during work,
>>>     something I could fix by changing resolution baqck and forth.  X
>>>     also tended to get
>>>     stuck for a minute now and then - a problem I haven't seen since
>>>     early 2.6.
>>>
>>>
>>>
>>> which head the radeon or MGA or both?
>>
>>The radeon 9200SE-pci gets stuck.  The MGA-agp seems to be fine. I have
>>compiled
>>dri support for both, but I can't use it at the moment.  I think that is
>>caused by having ubuntu's xorg installed on debian.  I needed xorg
>>in order to run an xserver that doesn't use any tty - this way I can use
>>two keyboards and have two simultaneous users. Debians xorg wasn't ready
>>at the moment. The setup is fine with 2.6.13-rc4-mm1 x86-64, no problems
>>there.
>
>I have some other issue with a MGA card (don't know exactly which, I have
> only access to this on the weekend). With rc5 and rc6 kdm will not start on
> bootup, X complains about some unresolved symbols in the X mga driver. If I
> log in as user and do startx it works fine, also if I switch back to
> 2.6.12-rc-something. Something seems to confuse X somehow.
>
>It's a PII-350 with more or less SuSE 9.3. The machine has no net access, so
> I can only try to narrow it down to one rc at the weekend.

2.6.12 works fine, everything since 2.6.13-rc1 breaks it.

Eike

--nextPart19745969.NGhCgWe2R8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDCYZiXKSJPmm5/E4RArUhAKCWmcvWyRsy/J0iVqGnco54zJCNxwCfWIvZ
hzFKzeRhpxxRXXJhiuZArnA=
=hhwF
-----END PGP SIGNATURE-----

--nextPart19745969.NGhCgWe2R8--
