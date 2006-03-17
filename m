Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752585AbWCQKnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbWCQKnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 05:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbWCQKnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 05:43:15 -0500
Received: from ironport1.mynow.co.uk ([81.91.192.235]:24212 "EHLO
	ironport1.mynow.co.uk") by vger.kernel.org with ESMTP
	id S1752585AbWCQKnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 05:43:14 -0500
X-BrightmailFiltered: true
From: "David J. Wallace" <katana@onetel.com>
To: sdhci-devel@list.drzeus.cx, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Sdhci-devel] Submission to the kernel?
Date: Fri, 17 Mar 2006 10:42:47 +0000
User-Agent: KMail/1.8.2
References: <4419FA7A.4050104@cogweb.net>
In-Reply-To: <4419FA7A.4050104@cogweb.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4128332.Ct8g3aRNfr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603171042.52589.katana@onetel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4128332.Ct8g3aRNfr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 16 March 2006 23:53, David Liontooth wrote:

>
> I would urge people to test Andrew's latest -mm kernel and report to
> lkml (cc him) on whether the sdhci driver works or causes any kind of
> problem.=20

sdhci is working fine here on my Panasonic CF-R4. Read speeds seem to be ab=
out=20
1.5MB/s with writes being a tad slower. This is on a 1GB Lexar SD card usin=
g=20
=46AT.  I have tested both 2.6.16-rc6-mm1 and a patched 2.6.15 without issu=
es.

I can provide logs etc if required, but at present I am happily using the=20
driver. I'm not subscribed so please cc me if required.

lspci:

00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express=20
Processor to DRAM Controller (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GM=
L=20
Express Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML Expre=
ss=20
Graphics Controller (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Famil=
y)=20
USB UHCI #1 (rev 04)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Famil=
y)=20
USB2 EHCI Controller (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FR=
W=20
(ICH6 Family) AC'97 Audio Controller (rev 04)
00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97=
=20
Modem Controller (rev 04)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge=
=20
(rev 04)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family=
)=20
IDE Controller (rev 04)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus=
=20
Controller (rev 04)
06:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd.=20
RTL-8139/8139C/8139C+ (rev 10)
06:04.0 Network controller: Intel Corporation PRO/Wireless 2915ABG MiniPCI=
=20
Adapter (rev 05)
06:05.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8d)
06:05.1 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (=
rev=20
13)

Now to get hotkeys working on this laptop...

Regards,

David


--nextPart4128332.Ct8g3aRNfr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEGpKsKsvwCXwmAPgRAl5SAKCB6stWAox+CFZoLFxtUglIqVKUwgCeIayR
SfTfTgAf5sB15ErrJ22QrMs=
=n00v
-----END PGP SIGNATURE-----

--nextPart4128332.Ct8g3aRNfr--
