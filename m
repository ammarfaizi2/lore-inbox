Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272773AbTHKQQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272781AbTHKQOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:14:20 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:4102 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272773AbTHKQN5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:13:57 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [2.6-test3] bttv driver doesn't run
Date: Mon, 11 Aug 2003 18:13:20 +0200
User-Agent: KMail/1.5.3
References: <200308092104.48878.fsdeveloper@yahoo.de> <20030811121546.GA8998@bytesex.org>
In-Reply-To: <20030811121546.GA8998@bytesex.org>
Cc: video4linux-list@redhat.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308111813.56558.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 11 August 2003 14:15, Gerd Knorr wrote:
> Yea, the reinitialize function doesn't re-enable the interrupts.
> Try latest patches from bytesex.org/patches/ which have this fixed, that
> should improve error recovery ...

I applied this patch:
http://bytesex.org/patches/2.6.0-test3/patch-2.6.0-test3-kraxel.gz

bttv run's fine, now.
I only got some small error-messages recently:

Aug 11 18:08:58 lfs kernel: bttv0: skipped frame. no signal? high irq latency?
Aug 11 18:10:57 lfs last message repeated 2 times

Most error messages I got before have gone and my tv-application
runs fine.

Thank you, for support, Gerd.

>   Gerd

- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Animals on this machine: some GNUs and Penguin 2.6.0-test3

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/N8DAoxoigfggmSgRAowNAJ9kh1kB08tEqh2b3ew1uGToS93PwACeK8sg
h2KeiMi4k+k8JEEHMK3ZYRI=
=j5bm
-----END PGP SIGNATURE-----

