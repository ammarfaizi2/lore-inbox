Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280664AbRKSToI>; Mon, 19 Nov 2001 14:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280663AbRKSTn6>; Mon, 19 Nov 2001 14:43:58 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:52643 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S280664AbRKSTnm> convert rfc822-to-8bit;
	Mon, 19 Nov 2001 14:43:42 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Slo Mo Snail <slomosnail@gmx.net>
Reply-To: slomosnail@gmx.net
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
Date: Mon, 19 Nov 2001 20:44:33 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0111191003470.8205-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111191003470.8205-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <20011119194350Z280664-17408+16369@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Montag, 19. November 2001 19:07 schrieb Linus Torvalds:
> On Mon, 19 Nov 2001, Sebastian Dröge wrote:
> > Hi,
> > I couldn't answer ealier because I had some problems with my ISP
> > the heavy swapping problem while burning a cd is solved in pre6aa1
> > but if you want i can do some statistics tommorow
>
> Well, pre6aa1 performs really badly exactly because it by default doesn't
> swap enough even on _normal_ loads because Andrea is playing with some
> tuning (and see the bad results of that tuning in the VM testing by
> rwhron@earthlink.net).
>
> So the pre6aa1 numbers are kind of suspect - lack of swapping may not be
> due to fixing the problem, but due to bad tuning.
>
> Does plain pre6 solve it? Plain pre6 has a fix where a locked shared
> memory area would previously cause unnecessary swapping, and maybe the CD
> burning buffer is using shmlock..

Hi,
yes plain pre6 seems to solve it, too. I can't be sure right now because I 
have recorded only 3 CDs while running pre6
pre6 swaps more than aa1 but I had so far I had no buffer-underuns and much 
of the swap appears in SwapCached
the interactive performance seems to be much better in pre6 than in aa1 so 
I'll stay with pre6 ;)
Bye
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7+WEovIHrJes3kVIRAg+nAJ4issDSimDEal2I08CQHEoXBpGFLQCeNQ1x
AathQZ75U5nhnEZwTkR4WnI=
=lb0O
-----END PGP SIGNATURE-----
