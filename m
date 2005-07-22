Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVGVVFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVGVVFC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVGVVFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:05:02 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:63156 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S262171AbVGVVFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:05:00 -0400
Message-ID: <42E160E3.8010006@stesmi.com>
Date: Fri, 22 Jul 2005 23:10:59 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Eckenfels <be-mail2005@lina.inka.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: a 15 GB file on tmpfs
References: <E1Dvusr-00048r-00@calista.eckenfels.6bone.ka-ip.net> <42E0D1C2.8080703@stesmi.com> <20050722162539.GA25577@lina.inka.de>
In-Reply-To: <20050722162539.GA25577@lina.inka.de>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bernd Eckenfels wrote:
> On Fri, Jul 22, 2005 at 01:00:18PM +0200, Stefan Smietanowski wrote:
> 
>>>You cant have 16GB of Memory with 32bit CPUs.
>>
>>PAE
>>CONFIG_HIGMEM64G
>>Supports a 36bit address space, which Xeons do support.
> 
> 
> Yes right, I was just not aware recent hardware (still) supports that. I
> mean even mit 2MB modules most of them are specified only to 8GB. I would
> consider buying such a system quite foolish. All of the HP servers with 12GB
> and more seem to support EM64T. Do you know vendors who ship non-EM64T
> servers with more than 16GB?

http://www.intel.com/products/processor/xeon/index.htm

Shows that the lowest speed Xeon with EM64T is 2.83GHz.

http://commerce.euro.dell.com/dellstore/config/frameset.asp?c=607&n=3410&b=62417&m=gbp&cs=ukbsdt1&sbc=ukbsdpedge&v=d&cu=etstore&l=en&s=ukbsd&store=ukbsd

Shows a system taking 1-4 of those processors at 2.0, 2.2, 2.7 and
3.0GHz, making them 32bit only.

Memory you can configure is from 1GiB (4x256MiB) to 32GiB (16x2GiB).

If I'd buy a server I wouldn't buy one of those however, I'm just
answering the question.

Disclaimer: I do not have anything to do with either of the above
mentioned vendors. I just looked up the first vendor that came into
my head.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFC4WDjBrn2kJu9P78RAn9RAJ9wRffW5VB0WbRgRBNjfN9+k3XMvgCgtWAO
mu8p8nj8iIpNIkuYiMkiTuI=
=9kQz
-----END PGP SIGNATURE-----
