Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262949AbVCWWKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVCWWKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbVCWWKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:10:32 -0500
Received: from mx2.mail.ru ([194.67.23.122]:28233 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S262949AbVCWWKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:10:16 -0500
From: Vladimir Kondratiev <vkondra@mail.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: wireless 2.6 work
Date: Thu, 24 Mar 2005 00:07:02 +0200
User-Agent: KMail/1.7
Cc: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
       Netdev <netdev@oss.sgi.com>, Dan Williams <dcbw@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       James Ketrenos <jketreno@linux.intel.com>
References: <20050310025036.GE17854@ruslug.rutgers.edu> <4240D158.1060302@pobox.com>
In-Reply-To: <4240D158.1060302@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9429505.gCS1A5zDSB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503240007.11954.vkondra@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9429505.gCS1A5zDSB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I did posted once; it was long time ago. I am sure I sent it to Dave. I can=
=20
resend if needed. Basically, I made Dave's stack work on 2.6 kernels; did=20
some changes toward QoS and provided simple utility to imitate low level=20
driver. I was concentrated on interfaces, it is still just skeleton.

I did not touched this work since then. I used to do stuff very close to=20
802.11 stack. Now I am very busy with some different work.
I can however consult on any 802.11 standard issues, QoS in particular.

Maybe, it is good idea to talk to James Ketrenos as well. Last time I saw h=
im=20
doing good work on .11 stack.

Vladimir

On Wednesday 23 March 2005 04:15, Jeff Garzik wrote:
JG> Luis R. Rodriguez wrote:
JG> > Jeff,
JG> >
JG> > I'm sick off the low activity and slow support on wireless we have. I
JG> > know you're busy so I wanted to offer my help in helping around work =
on
JG> > wireless-2.6, now that I have time after work, and before I commit
JG> > myself to anything else. It's a bit suicidal, but oh well. Oh yeah and
JG> > I'll also start using bitkeeper due to the recent clarifications on t=
he
JG> > license of its usage.
JG>
JG> Great!  While I think BitKeeper is useful, you are more than welcome to
JG> continue sending patches.
JG>
JG> To wireless developers, BitKeeper will mainly be of use in sync'ing with
JG> the latest wireless-2.6 tree.
JG>
JG>
JG> > I'll willing to review as much patches as I have to and also hopefully
JG> > write documentation on writing new wireless drivers. That said, if I
 can JG> > be of any assistance, where what you like me to start on?
JG> >
JG> > Here's what's on my agenda so far:
JG> >
JG> > * Help cleanup new ralink driver, start using ieee802211 and get into
 wireless-2.6. JG> > * Push prism54's new WPA and WDS support into
 wireless-2.6
JG> > * Start seeing what I can use off of ieee80211 for prism54, clean it,
JG> >   and move to wireless-2.6
JG> > * Start incorporating WPA through wpa_supplicant onto as many drivers
JG> > * Start standardizing all things a bit, as bitched about and well
 pointed out JG> >   by Dan Williams <dcbw@redhat.com>
JG> > * Listen to Jouni, he's the man
JG>
JG> Well, all this sounds good to me.  See also the 'status' post I just
JG> made, and the 'note on wireless development process' I am about to writ=
e.
JG>
JG> I'm really hoping someone will look into integrating wireless 802.11 as
JG> a "real" protocol, rather than faking ethernet.  This work starts with
JG> the "p80211" template DaveM provided, and hopefully continues with
JG> Vladimir's updates of DaveM's code (did he post those anywhere?).  There
JG> are also issues such as ARP types that Dan Williams mentioned to me as
JG> issues.
JG>
JG> The "integrate wireless into net stack" work requires a very
JG> self-motivated person who is willing to poke into the net stack, and
JG> answer their own questions.
JG>
JG>  Jeff
JG>
JG>
JG>
JG>
JG>

--nextPart9429505.gCS1A5zDSB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQeiOqxdj7mhC6o0RAhwlAKCXVdrBJ+4GMl3wvY1I2VF8i7oHQgCfX2k7
YiFDk03gK3t8bRVOcbJwW5E=
=kAfI
-----END PGP SIGNATURE-----

--nextPart9429505.gCS1A5zDSB--
