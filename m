Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVDLLYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVDLLYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVDLLXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:23:14 -0400
Received: from port49.ds1-van.adsl.cybercity.dk ([212.242.141.114]:7794 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id S262323AbVDLKo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:44:28 -0400
Message-ID: <425BA688.9010607@ubuntu.com>
Date: Tue, 12 Apr 2005 12:44:24 +0200
From: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: MV643XX ethernet is an option for Pegasos
References: <1113289985.21548.66.camel@gaston> <20050412095522.GA20129@xyzzy>
In-Reply-To: <20050412095522.GA20129@xyzzy>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dale Farnsworth wrote:
> On Tue, Apr 12, 2005 at 07:13:04AM +0000, Benjamin Herrenschmidt wrote:
> 
>>This patch allows Kconfig to build the MV643xx ethernet driver on
>>Pegasos (CONFIG_PPC_MULTIPLATFORM) and adds what I think is a missing
>>fix from Dale's batch, that is remove SA_INTERRUPT and add SA_SHIRQ in
>>there as the interrupt is shared if I understand things correctly.
>>
>>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>Signed-off-by: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
> 
> 
> This looks identical to the patch I posted to netdev two weeks ago
> as the first of 20 patches for the MV643xx ethernet driver.
> 
> See <http://oss.sgi.com/archives/netdev/2005-03/msg01644.html> and
> <http://oss.sgi.com/archives/netdev/2005-03/msg01642.html>.

It is possible. I received an old patch from Sven Luther and bounced to
Benjamin rediffed against 2.6.12rc2, but the bits ended to be exactly
the same.

Fabio

PS feel free to claim credits on it. I don't want for sure take over
your work :)

- --
Self-Service law:
The last available dish of the food you have decided to eat, will be
inevitably taken from the person in front of you.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQlumhlA6oBJjVJ+OAQK/NQ/9FLAIyMR+8fnpOygf7PVFSC0bEMZ9GVuk
apCzX79QOjKAOOEaI/oSZEaH6K4/93lnUS1CjUiRYCv43mQ9RIw5cSs+if6TqSUF
UOzRiFIg269BTIvIJVklsGUN+lC0C3Z66VQzWYkS84UJ3gQoHs55IRhccWqVMO2p
L/VrcypZV5yD7OmqfsE7JJ4EYWtg/K3xigz+y7ZkyOfhuKWJdFbtRM+jjm67gMGq
J+IqXgLpN4dMp/C0woVjfE2/mebqiBN2ft6qPCYlgwXKXN7wPKcSodMpK6D64x6T
juvaSn6wgvQWmuRJh9bRBkHBM78eYiGFfBa4Mh8Il2aNrLmxjn8I52/wfq/wXd8j
4sDCnIC6YtNf5dbhK2jY6M9YCBs3SxzJu9O6yCjGGVfp0dpnPLFpbiZnWMAXQGz4
sVA7YCejkUJYMiJY9mlIh7960+V+g+PIBCk7myaOML24bsUp7AfAJtzdqQZqFSau
ZpD0e77prl16F4gOb+pMt+JGVeOWeZqVuhg8GlklFaAHGVBujE9Zb+uKh4ZTeag9
ksxWDZACe/kxNc9rFvBpabNLzK5oi4Tn4LWVRr105c6nLSXwladckUnT3MCSTwHU
yRD5YOerF0Rerh6OyWYw8FoG+vHSfIm6w87QxNSgQMjv6wOhZRVTyukF/A2V42tw
nq3U4qR66hM=
=uGjK
-----END PGP SIGNATURE-----
