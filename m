Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266518AbUBERsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266520AbUBERsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:48:31 -0500
Received: from srv1a-cta.bs2.com.br ([200.203.183.35]:56333 "EHLO
	srv1a-cta.bs2.com.br") by vger.kernel.org with ESMTP
	id S266518AbUBERs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:48:27 -0500
Message-ID: <402281E3.6020405@gardenali.biz>
Date: Thu, 05 Feb 2004 15:48:19 -0200
From: Evaldo Gardenali <evaldo@gardenali.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: problem on __alloc_pages
References: <402244FE.5010107@gardenali.biz> <Pine.LNX.4.58L.0402051516580.16120@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402051516580.16120@logos.cnet>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcelo Tosatti wrote:
|
| On Thu, 5 Feb 2004, Evaldo Gardenali wrote:
|
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>Hi.
|>I am a newbie to kernel memory alloc, and got this on my server.
|>
|>Feb  5 11:09:39 server1 kernel: __alloc_pages: 1-order allocation failed
|>(gfp=0x1f0/0)
|>Feb  5 11:09:39 server1 kernel: __alloc_pages: 0-order allocation failed
|>(gfp=0x1f0/0)
|>Feb  5 11:10:36 server1 kernel: __alloc_pages: 0-order allocation failed
|>(gfp=0x1d2/0)
|>Feb  5 11:11:18 server1 kernel: __alloc_pages: 0-order allocation failed
|>(gfp=0x1d2/0)
|>Feb  5 11:11:18 server1 kernel: __alloc_pages: 0-order allocation failed
|>(gfp=0x1d2/0)
|>Feb  5 11:11:18 server1 kernel: __alloc_pages: 0-order allocation failed
|>(gfp=0xf0/0)
|>Feb  5 11:11:18 server1 kernel: __alloc_pages: 0-order allocation failed
|>(gfp=0x1d2/0)
|>Fev  5 11:11:39 server1 gconfd (evaldo-2337): Recebido sinal 15,
|>desligando corretamente
|>Fev  5 11:11:40 server1 gconfd (evaldo-2337): Terminando
|>Feb  5 11:11:52 server1 /usr/sbin/gpm[437]: imps2: Auto-detected
|
|
| Hi Evaldo,
|
| Do you have swap space available when this happens?
|

Absolutely. this box never gets 500M swap used. highest I ever saw is
400M on VERY HIGH activity (which happened only once, when we had a task
force going on here). right now, swap usage is 3M
I just added 500M more swap to it, just in case (swap partition)

Oh. and I had memtest86 run the 'full test' for 4 days non-stop before
going production ;)

Thanks
Evaldo Gardenali
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAIoHj5121Y+8pAbIRAjQ3AKCgaj3ObSAd9lGN116n5vzjhs7bYACcCESO
3oXSuOE29piYqrybtruUSZk=
=awtt
-----END PGP SIGNATURE-----
