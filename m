Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVHQLYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVHQLYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 07:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVHQLYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 07:24:32 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:11222 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751088AbVHQLYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 07:24:31 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes. Also some X trouble.
Date: Wed, 17 Aug 2005 13:26:15 +0200
User-Agent: KMail/1.8.2
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <21d7e99705080503515e3045d5@mail.gmail.com> <42F89F79.1060103@aitel.hist.no>
In-Reply-To: <42F89F79.1060103@aitel.hist.no>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2262986.hpTXZNNCr0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508171326.21948@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2262986.hpTXZNNCr0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Helge Hafting wrote:
>Dave Airlie wrote:
>>     I switched back to 2.6.13-rc4-mm1 at this point for another reason,
>>     my X display aquired a nasty tendency to go blank for no reason
>>     during work,
>>     something I could fix by changing resolution baqck and forth.  X
>>     also tended to get
>>     stuck for a minute now and then - a problem I haven't seen since
>>     early 2.6.
>>
>>
>>
>> which head the radeon or MGA or both?
>
>The radeon 9200SE-pci gets stuck.  The MGA-agp seems to be fine. I have
>compiled
>dri support for both, but I can't use it at the moment.  I think that is
>caused by having ubuntu's xorg installed on debian.  I needed xorg
>in order to run an xserver that doesn't use any tty - this way I can use
>two keyboards and have two simultaneous users. Debians xorg wasn't ready
>at the moment. The setup is fine with 2.6.13-rc4-mm1 x86-64, no problems
>there.

I have some other issue with a MGA card (don't know exactly which, I have o=
nly=20
access to this on the weekend). With rc5 and rc6 kdm will not start on=20
bootup, X complains about some unresolved symbols in the X mga driver. If I=
=20
log in as user and do startx it works fine, also if I switch back to=20
2.6.12-rc-something. Something seems to confuse X somehow.

It's a PII-350 with more or less SuSE 9.3. The machine has no net access, s=
o I=20
can only try to narrow it down to one rc at the weekend.

Eike

--nextPart2262986.hpTXZNNCr0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDAx7dXKSJPmm5/E4RAkKLAKCd6Xjsa0KUGjsOTV5x8joQOs1jdACfSRZN
y5iLQ1uCzWIXzNijl/aklk8=
=9Pt8
-----END PGP SIGNATURE-----

--nextPart2262986.hpTXZNNCr0--
