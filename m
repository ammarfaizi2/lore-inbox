Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVCGAS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVCGAS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVCGARz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:17:55 -0500
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:31504 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261578AbVCGAJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:09:13 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
Organization: IBM LTC
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 breaks ALSA Intel AC97 audio
Date: Mon, 7 Mar 2005 11:09:08 +1100
User-Agent: KMail/1.7.2
References: <422A3C7F.3020501@yahoo.com>
In-Reply-To: <422A3C7F.3020501@yahoo.com>
Cc: Lars <lhofhansl@yahoo.com>
MIME-Version: 1.0
Message-Id: <200503071109.08641.michael@ellerman.id.au>
Content-Type: multipart/signed;
  boundary="nextPart1880358.fLGNEjNp2p";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1880358.fLGNEjNp2p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Lars,

Yeah I've got no audio on my T41, which I think uses the AC97 too. I haven'=
t=20
had time to look into it though :/

cheers

On Sun, 6 Mar 2005 10:10, Lars wrote:
> With Kernel 2.6.11 the Audio driver in my ThinkPad T42 stopped working.
> The dsp device is detected and readable/writable, but there's no
> audible sound.
> Everything worked fine with 2.6.9 and 2.6.10.
> Did anybody else see this?
>
> /proc/pci:
> ----------
>
>    Bus  0, device  31, function  5:
>      Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 1).
>        IRQ 11.
>        I/O at 0x1c00 [0x1cff].
>        I/O at 0x18c0 [0x18ff].
>        Non-prefetchable 32 bit memory at 0xc0000c00 [0xc0000dff].
>        Non-prefetchable 32 bit memory at 0xc0000800 [0xc00008ff].
>
> Kernel sound config:
> --------------------
>
> #
> # Sound
> #
> CONFIG_SOUND=3Dm
>
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=3Dm
> CONFIG_SND_TIMER=3Dm
> CONFIG_SND_PCM=3Dm
> CONFIG_SND_RAWMIDI=3Dm
> CONFIG_SND_SEQUENCER=3Dm
> CONFIG_SND_SEQ_DUMMY=3Dm
> CONFIG_SND_OSSEMUL=3Dy
> CONFIG_SND_MIXER_OSS=3Dm
> CONFIG_SND_PCM_OSS=3Dm
> CONFIG_SND_SEQUENCER_OSS=3Dy
> CONFIG_SND_RTCTIMER=3Dm
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
>
> #
> # Generic devices
> #
> CONFIG_SND_MPU401_UART=3Dm
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> CONFIG_SND_MPU401=3Dm
>
> #
> # PCI devices
> #
> CONFIG_SND_AC97_CODEC=3Dm
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_ATIIXP is not set
> # CONFIG_SND_ATIIXP_MODEM is not set
> # CONFIG_SND_AU8810 is not set
> # CONFIG_SND_AU8820 is not set
> # CONFIG_SND_AU8830 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_BT87X is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_EMU10K1X is not set
> # CONFIG_SND_CA0106 is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_MIXART is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_YMFPCI is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> CONFIG_SND_INTEL8X0=3Dm
> CONFIG_SND_INTEL8X0M=3Dm
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VIA82XX_MODEM is not set
> # CONFIG_SND_VX222 is not set
>
> Loaded Modules:
> ---------------
>
> snd_intel8x0           28864  1
> snd_ac97_codec         75256  1 snd_intel8x0
> snd_pcm_oss            50016  0
> snd_mixer_oss          17856  1 snd_pcm_oss
> snd_pcm                82120  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
> snd_timer              20740  1 snd_pcm
> snd                    45156  8
> snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
> soundcore               7008  1 snd
> snd_page_alloc          7620  2 snd_intel8x0,snd_pcm
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
Michael Ellerman
OzLabs Canberra
IBM Linux Technology Centre
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Phone: +61 2 6212 1183
Email: michael@ellerman.id.au
WWWeb: http://michael.ellerman.id.au



--nextPart1880358.fLGNEjNp2p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCK5ukdSjSd0sB4dIRAnrqAJ45kz6p63lUn0s5wcS5ZELo8CFEuQCgxK+8
SHP7xnjhqirroziYCCY0LeE=
=vprS
-----END PGP SIGNATURE-----

--nextPart1880358.fLGNEjNp2p--
