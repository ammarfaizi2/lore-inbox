Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSEXC2c>; Thu, 23 May 2002 22:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSEXC2b>; Thu, 23 May 2002 22:28:31 -0400
Received: from pat.uio.no ([129.240.130.16]:38039 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317072AbSEXC2b>;
	Thu, 23 May 2002 22:28:31 -0400
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Latest ALSA code available for tests
In-Reply-To: <acid77$c07$2@main.gmane.org>
From: ilmari@ping.uio.no (Dagfinn Ilmari =?iso-8859-1?q?Manns=E5ker?=)
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Date: Fri, 24 May 2002 04:28:24 +0200
Message-ID: <d8ju1oynut3.fsf@thrir.ifi.uio.no>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2
 (sparc-sun-solaris2.7)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Jaroslav Kysela <perex@suse.cz> writes:

> Hi all,
>
> 	the latest ALSA -> kernel patch is available for tests at
>
> ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-2002-05-23-1-linux-2.5=
.17-cs1.582.patch.gz
>
> 	I'd like to ask interested people to test this patch and report
> especially compilation problems, because there are some fixes in code
> dependency for OSS emulation layer. Also Hammerfall DSP code was recently
> added.

It all compiled fine here, and depmod doesn't complain about any
unresolved symbols. However, when I try to load snd.o, it tells that
snd_mixer_oss_notify_callback is unresolved. The relevant config
parameters are:

CONFIG_SOUND=3Dy
CONFIG_SND=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_RTCTIMER=3Dm
CONFIG_SND_MAESTRO3=3Dm

=2D-=20
ilmari
--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.0.6 (SunOS)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE87aVM1C7NxFHs+sYRAhKqAJ4gQ+KkZQI1r89nftOYcf9zVgYCGQCgknCW
rFYpH43vVuji+XVKz1JrIGk=
=a2Tt
-----END PGP MESSAGE-----
--=-=-=--
