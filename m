Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUF0Sxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUF0Sxx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 14:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUF0Sxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 14:53:53 -0400
Received: from ms-1.rz.RWTH-Aachen.DE ([134.130.3.130]:65274 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S261375AbUF0Sxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 14:53:51 -0400
Date: Sun, 27 Jun 2004 20:52:38 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
In-reply-to: <40DF0A98.9040604@travellingkiwi.com>
To: Hamie <hamish@travellingkiwi.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Message-id: <200406272052.43326@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
References: <1088160505.3702.4.camel@tyrosine>
 <40DDBA7A.6010404@travellingkiwi.com> <40DF0A98.9040604@travellingkiwi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Sonntag, 27. Juni 2004 19:57 schrieb Hamie:
> FWIW the sound & networking appear to run fine for a while after
> resuming. But I just started a DVD. It ran fine for about 30 seconds and
> then the sound went. About 30 seconds later the video froze and the app
> (xine) has frozen also. (kill -9 time...).

I can confirm that here:
after resuming, network completely works (yeah!).
Sound doesn't.
unloading/reloading the sound driver does not help.
USB works jumpy (perhaps 5-10hz)
Reloading does the trick for usb.

regards
Alex

- -- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3xd5/aHb+2190pERAmTsAJ0Q9iFLAGC6pbMZgTMjlv0BpmSALgCfTOmS
Ye+xHeQfxA/qrcUroQmdmJw=
=oyv2
-----END PGP SIGNATURE-----

