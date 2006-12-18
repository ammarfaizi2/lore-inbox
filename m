Return-Path: <linux-kernel-owner+w=401wt.eu-S1750873AbWLRBUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWLRBUX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 20:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWLRBUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 20:20:23 -0500
Received: from avas-mr14.fibertel.com.ar ([24.232.0.245]:49171 "EHLO
	avas-mr14.fibertel.com.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbWLRBUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 20:20:22 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 20:20:22 EST
Subject: Backlight bright-up causes X to restart after HP laptop BIOS
	upgrade
From: Javier Kohen <jkohen@users.sourceforge.net>
Reply-To: jkohen@users.sourceforge.net
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-igYA693qc4g7M/vPj2zq"
Date: Sun, 17 Dec 2006 22:09:56 -0300
Message-Id: <1166404196.3802.30.camel@null.tough.com.ar>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
X-Fib-Al-Info: Al
X-Fib-Al-MRId: 5fb8949a215d7c6eb6d0165f129b7241
X-Fib-Al-SA: analyzed
X-Fib-Al-From: jkohen@users.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-igYA693qc4g7M/vPj2zq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I own a HP dv8301nr notebook. It has an AMD64 CPU (running a 32-bit
Debian), ATI chipset and ATI Radeon XPRESS 200M 5955 graphic card. I'm
running an untainted Linux 2.6.19-ck2. X.org is using the open-source
ATI driver.

I upgraded the laptop's BIOS to version F.52 earlier today. Since then
X.org started shutting down every time upon pressing the bright-up key.
Also, the kernel started printing "video device notify" on bright-down
and that same line followed by "set_level status: 0" on bright-up. I
adjust the backlight frequently, so I know for a fact that this was
working yesterday before the BIOS upgrade.

Some relevant parts of my kernel config:
CONFIG_FB=3Dm
# CONFIG_FB_* is not set, not even the Radeon one
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm
CONFIG_BACKLIGHT_DEVICE=3Dy
CONFIG_LCD_CLASS_DEVICE=3Dm
CONFIG_LCD_DEVICE=3Dy
CONFIG_PM=3Dy
CONFIG_PM_LEGACY=3Dy
CONFIG_ACPI=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dm
CONFIG_ACPI_VIDEO=3Dm
CONFIG_ACPI_HOTKEY=3Dm
CONFIG_ACPI_FAN=3Dm
CONFIG_ACPI_DOCK=3Dm
CONFIG_ACPI_PROCESSOR=3Dm
CONFIG_ACPI_THERMAL=3Dm
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_X86_PM_TIMER=3Dy
# CONFIG_ACPI_CONTAINER is not set

Module                  Size  Used by
binfmt_misc             7624  1
af_packet              10824  2
ipv6                  189728  12
video                  13252  0
button                  4880  0
ac                      3524  0
battery                 7940  0
realtime                3720  0
commoncap               4864  1 realtime
ext2                   42248  1
snd_seq_dummy           2564  0
snd_seq_oss            24896  0
snd_seq_midi            5792  0
snd_rawmidi            16352  1 snd_seq_midi
snd_seq_midi_event      5312  2 snd_seq_oss,snd_seq_midi
snd_seq                37584  6
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_seq_device          5836  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
cpufreq_ondemand        5696  1
cpufreq_conservative     5280  0
cpufreq_powersave       1472  0
powernow_k8             8396  0
freq_table              3268  2 cpufreq_ondemand,powernow_k8
snd_atiixp             13516  1
snd_atiixp_modem       10568  5
snd_ac97_codec         84644  2 snd_atiixp,snd_atiixp_modem
snd_ac97_bus            1856  1 snd_ac97_codec
snd_pcm_oss            31968  0
snd_mixer_oss          12800  1 snd_pcm_oss
bcm43xx               401504  0
snd_pcm                51912  6
snd_atiixp,snd_atiixp_modem,snd_ac97_codec,snd_pcm_oss
ieee80211softmac       22272  1 bcm43xx
snd_timer              15428  2 snd_seq,snd_pcm
tifm_7xx1               5056  0
tifm_core               5776  1 tifm_7xx1
snd                    37732  21
snd_seq_oss,snd_rawmidi,snd_seq,snd_seq_device,snd_atiixp,snd_atiixp_modem,=
snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
yenta_socket           21068  0
rsrc_nonstatic          8256  1 yenta_socket
pcmcia_core            28688  2 yenta_socket,rsrc_nonstatic
ieee80211              24968  2 bcm43xx,ieee80211softmac
ieee80211_crypt         4032  1 ieee80211
k8temp                  4032  0
psmouse                30920  0
soundcore               5344  1 snd
snd_page_alloc          6920  3 snd_atiixp,snd_atiixp_modem,snd_pcm
evdev                   6912  2
pcspkr                  2176  0
dm_mirror              14096  0
dm_snapshot            12320  0
dm_mod                 39832  9 dm_mirror,dm_snapshot
8139cp                 15552  0
ide_cd                 31456  0
cdrom                  30112  1 ide_cd
ide_disk               11840  3
8139too                18688  0
mii                     4224  2 8139cp,8139too
crc32                   3904  2 8139cp,8139too
ohci1394               26928  0
ieee1394               72184  1 ohci1394
atiixp                  4496  0 [permanent]
ide_core               93212  3 ide_cd,ide_disk,atiixp
ehci_hcd               23624  0
ohci_hcd               15428  0
usbcore                99716  3 ehci_hcd,ohci_hcd
thermal                10952  0
processor              18348  2 powernow_k8,thermal
fan                     3332  0

Although the lcd and backlight modules are not loaded, loading them at
one point didn't seem to help.

I noticed the following change in the ACPI table as reported during the
boot-up sequence. Other than this, I've noticed no other changes:
 ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7c20
-ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
0x3fea4598
+ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
0x3fea3f15
 ACPI: FADT (v001 HP     Piranha  0x06040000 ATI  0x000f4240) @
0x3feabe3b
 ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @
0x3feabeaf=09
 ACPI: MADT (v001 PTLTD          APIC   0x06040000  LTP 0x00000000) @
0x3feabf7e-ACPI: MCFG (v001 PTLTD    MCFG   0x06040000  LTP 0x00000000)
@ 0x3feabfc4
+ACPI: MCFG (v001 HP     PORSCHE  0x06040000 LOHR 0x00000000) @
0x3feabfc4
 ACPI: DSDT (v001     HP     309B 0x06040000 MSFT 0x0100000e) @
0x00000000

Don't hesitate to ask me for anything that could help track this
problem. Please honor the Reply-To header, as I'm not subscribed to this
list.

PS: I upgraded the BIOS, as the new version is supposed to include some
keyboard/mousepad-related fixes for Vista. Since then I haven't
experienced any of the Synaptics mousepad hick-ups that had been driving
me nuts.

Thanks for your time,
--=20
Javier Kohen <jkohen@users.sourceforge.net>
ICQ: blashyrkh #2361802
Jabber: jkohen@jabber.org

--=-igYA693qc4g7M/vPj2zq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFhepj823633cP2P8RAkyKAJ4pHj6kXwK90KT7xTw9sIVbOhU1AgCdHxEz
7EO3/0pR2/6jV83lZzzbCxg=
=mK2+
-----END PGP SIGNATURE-----

--=-igYA693qc4g7M/vPj2zq--
