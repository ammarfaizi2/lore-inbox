Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265032AbUFANKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbUFANKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbUFANKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:10:08 -0400
Received: from pD952C7EB.dip.t-dialin.net ([217.82.199.235]:40653 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S265029AbUFANKC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:10:02 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Enable suspend/resuming of e1000
Date: Tue, 1 Jun 2004 15:04:37 +0200
User-Agent: KMail/1.6.2
References: <200405281404.10538@zodiac.zodiac.dnsalias.org> <20040601125008.GE10233@elf.ucw.cz>
In-Reply-To: <20040601125008.GE10233@elf.ucw.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406011504.40549@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Dienstag, 1. Juni 2004 14:50 schrieben Sie:
> Whitespace damage here (tabs vs. spaces) plus you really should not
> call procedure before variable declarations. Otherwise looks good.
>
> 								Pavel

Was my first patch to the kernel, sorry. However I still have trouble 
reenabling the card. It is recognized again (Withouth the driver thinks 
EEPROM is wrong).
tx is ok, but rx doesn't work. I suppose it's an interrupt problem, as the 
interrupt doesn't increase on rx. Will dig into it a bit further..

regards
Alex

- -- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAvH7n/aHb+2190pERAhSLAJ92ZS1cvWwjjo6oLiVkldpiA5XqhQCeKJDV
lqooJHS8J8ntBjN4hCw3G+k=
=/9FQ
-----END PGP SIGNATURE-----
