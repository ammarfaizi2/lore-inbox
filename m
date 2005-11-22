Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVKVNKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVKVNKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 08:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVKVNKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 08:10:31 -0500
Received: from relay16-159.bu.edu ([128.197.159.83]:58072 "EHLO
	relay16-159.bu.edu") by vger.kernel.org with ESMTP id S1751299AbVKVNKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 08:10:31 -0500
From: Geoff Mishkin <gmishkin@acs.bu.edu>
Reply-To: gmishkin@bu.edu
To: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.14.2 kernel oops, looks acpi-related
Date: Tue, 22 Nov 2005 08:09:51 -0500
User-Agent: KMail/1.8.1
References: <200511212050.10671.gmishkin@acs.bu.edu> <20051122072830.GB25419@kroah.com>
In-Reply-To: <20051122072830.GB25419@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2221638.CRHCyPMFvV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511220809.57038.gmishkin@acs.bu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2221638.CRHCyPMFvV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alright, I can do that.  What about cisco_ipsec and fglrx?  cisco_ipsec I=20
could live without, but fglrx would be difficult.  I've never been able to=
=20
get the radeon driver working on my system, at all.

Sorry if that sounds silly and the VMware drivers are the only ones that co=
uld=20
be possibly causing the problem.

Thanks for the response.

			--Geoff Mishkin <gmishkin@bu.edu>


On Tuesday 22 November 2005 02:28 am, you wrote:
> On Mon, Nov 21, 2005 at 08:50:03PM -0500, Geoff Mishkin wrote:
> > Unable to handle kernel paging request at virtual address 4b87ad6e
> >  printing eip:
> > c01f6b76
> > *pde =3D 00000000
> > Oops: 0000 [#1]
> > Modules linked in: uhci_hcd ehci_hcd vmnet parport_pc parport vmmon arc4
> > ieee80211_crypt_wep ieee80211_crypt nfs lockd sunrpc cisco_ipsec
> > ipt_state iptable_filter iptable_nat ip_nat ip_conntrack iptable_mangle
> > ip_tables pcmcia yenta_socket rsrc_nonstatic pcmcia_core snd_pcm_oss
> > snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
> > snd_seq_device snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_tim=
er
> > snd soundcore snd_page_alloc nls_iso8859_1 ntfs nls_base nvram usbhid
> > usb_storage usbcore tun e1000 evdev fglrx intel_agp agpgart rtc
> > speedstep_centrino freq_table ibm_acpi
> > CPU:    0
> > EIP:    0060:[<c01f6b76>]    Tainted: P   M  VLI
>
> Unfortunatly you have loaded the vmware drivers into your kernel, so we
> really can't help out much here.  If you can duplicate this without
> those drivers loaded, please file a bug at bugzilla.kernel.org.
>
> thanks,
>
> greg k-h

--nextPart2221638.CRHCyPMFvV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDgxilCByDbUAKi3URAgCGAKDDETdv3EyRHEBkUyyLz3+6zzGjzwCeJJVl
pSxsp3P+NDgR6oXENwU1VA4=
=RQ2q
-----END PGP SIGNATURE-----

--nextPart2221638.CRHCyPMFvV--
