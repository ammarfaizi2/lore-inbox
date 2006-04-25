Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWDYTLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWDYTLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWDYTLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:11:39 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:31653 "EHLO
	pne-smtpout3-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932295AbWDYTLj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:11:39 -0400
From: Jani-Matti =?iso-8859-1?q?H=E4tinen?= <jani-matti.hatinen@iki.fi>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: Lock-up with modprobe sdhci after suspending to ram
Date: Tue, 25 Apr 2006 22:11:36 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <515ed10f0604240033i71781bfdp421ed244477fd200@mail.gmail.com> <84144f020604250312w43df9fb4n864647c8d313a588@mail.gmail.com>
In-Reply-To: <84144f020604250312w43df9fb4n864647c8d313a588@mail.gmail.com>
X-Face: #cyYMAd}qudd3k4*S6mac8z1vRgtwXAC'7r{jv<~p5y80oOWqj0)0~/;,QeB(P>fhDJ"=?iso-8859-1?q?lF=0A=09=7D-ls=26?="0:\(7!/S)a_ew$J?hey[-+u`<VOlVBz48@)SW{u#N=v1P~`\Cd9^zw[>=?iso-8859-1?q?Z=607l=26XK=24=0A=09Deyz7Uf=5Dx?=@r"kOgh|l?F~QrgBEd<$x`a)[]1C"NqvG<T3Gk"@_,cH7Q;HTlZgb*F>VR(=?iso-8859-1?q?3j=0A=09=5ByC?=>>hR;jXQ!K/Q]*HjPibvm_33AQC_N2Z$VnZ<=?iso-8859-1?q?gy*4-QB2q=3A=5BoZ=2E-8YNsF+WK=27ya6u/!J=0A=09-4g=3B?=
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604252211.37635.jani-matti.hatinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg kirjoitti viestissään (lähetysaika tiistai, 25. huhtikuuta 2006 
13:12):
> Hi Jani,
>
> On 4/24/06, Jani-Matti Hätinen <jani-matti.hatinen@iki.fi> wrote:
> >   I've tested this with 2.6.15-gentoo-r1 with the sdhci-0.11 patches
> > and vanilla 2.6.17-rc2. Sadly nothing gets as far as to the log when
> > the lock-up occurs.
>
> If this is a regression from an earlier version, you could try git
> bisect to isolate the broken changeset. See the following URL for more
> details:
>
> http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bis
>ect.txt.

AFAIK the sdhci driver in 2.6.17-rc2 is effectively the same as the sdhci-0.11 
patches I used with 2.6.15-gentoo-r1. I haven't tested this with earlier 
versions of the driver, but I will as soon as mmc.drzeus.cx comes back 
online.
  Thanks for the link.

-- 
Jani-Matti Hätinen
