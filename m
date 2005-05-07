Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVEGRrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVEGRrx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 13:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVEGRrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 13:47:53 -0400
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:44732 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S262732AbVEGRru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 13:47:50 -0400
Message-ID: <427D000B.40803@stesmi.com>
Date: Sat, 07 May 2005 19:51:07 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ricky Beam <jfbeam@bluetronic.net>
CC: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <Pine.GSO.4.33.0505070228400.19035-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0505070228400.19035-100000@sweetums.bluetronic.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Ricky.

>>Not to be a pain but how exactly would that interface look today
>>in your eyes?

> Back when I first brought this up (8 years ago?), it was simple... numcpu
> was it.  There weren't any virtual processors or multi-core critters.

Weren't there? Hmm. First SMT implementation dates back to 1970.

Or the HEP-1 from 1982. Or the Tera from 1990.
They weren't called SMT though back then.

Irrelevant to the discussion though.

And no, "they didn't run Linux" doesn't cut it in my eyes.

People run Linux on anything, always have, always will.

> CPU affinity, cpumasks, and sysfs weren't even dreams.

> Today, things are more complicated... much more complicated.  However,
> they've generally already been hashed out and handled in some fashion.
> The kernel already knows how many cpus there are, how many are online,
> which ones are virtual (at least to the point that the scheduler knows),
> etc.  I'm not sure what difference multi-core chips really make as they're
> just two+ cpus in the same package -- yes, that means all of them have to
> be offline to physically remove the processor, but that's pretty hardcore,
> specialized function to begin with.

Pretty big generalization there. But tell me, a HT DualCore CPU - how
DO you think it should end up being visible?

Also, remember the some database vendors have said that they will charge
per cpu package and some have said it's per cpu core.

Whatever interface is chosen have to accomodate both.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCfQALBrn2kJu9P78RAus0AJ96rwWGKG5AyuchQRxSOZESFaPLqwCZAWeJ
nJLYcT7NsJhFB81eUYVP4v8=
=Wb0F
-----END PGP SIGNATURE-----
