Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264335AbUD2MOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbUD2MOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbUD2MOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:14:05 -0400
Received: from pD952C170.dip.t-dialin.net ([217.82.193.112]:28305 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S264316AbUD2MN6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:13:58 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Martin Hermanowski <martin@mh57.de>
Subject: Re: e1000 EEPROM wrong after suspending.
Date: Thu, 29 Apr 2004 14:13:55 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200404272353.27989@zodiac.zodiac.dnsalias.org> <20040428195429.GA11077@mh57.de>
In-Reply-To: <20040428195429.GA11077@mh57.de>
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200404291413.56687@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Mittwoch, 28. April 2004 21:54 schrieb Martin Hermanowski:
> I am using the e1000 on the t41p with enabled local apic, and I got no
> problem. But when I compiled the kernel (2.6.4-rc1-mm2) without local
> apic (so the notebook would turn off), I got the same problem. This was,
> besides a patch to the orinico driver, the only difference between the
> two kernels.
>
> The working one has these options set:
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y

just tried 2.6.6-rc2-mm2 with local apic:
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

but resuming stil doesn't work ;(

- -- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAkPGD/aHb+2190pERAvlhAKCoBS8y7O9/3ute7biYqbaX673l+gCgmeJR
XLUfQ5hfEgSorB5rSG4sqzI=
=ALKx
-----END PGP SIGNATURE-----
