Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266178AbUBSFk7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 00:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUBSFk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 00:40:59 -0500
Received: from main.gmane.org ([80.91.224.249]:12515 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266178AbUBSFk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 00:40:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
Date: Wed, 18 Feb 2004 13:40:34 -0800
Message-ID: <m2ekssf4ml.fsf@tnuctip.rychter.com>
References: <402A4B52.1080800@centrum.cz> <402A7765.FD5A7F9E@users.sourceforge.net>
 <m265e9oyrs.fsf@tnuctip.rychter.com>
 <402F877C.C9B693C1@users.sourceforge.net>
 <m2k72n9pth.fsf@tnuctip.rychter.com>
 <40322094.83061A32@users.sourceforge.net>
 <m24qtpikmd.fsf@tnuctip.rychter.com>
 <4033714A.FFFEBD6C@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1053host190.starwoodbroadband.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
Cancel-Lock: sha1:jWVeaDlRmBtirTw8QTRTsppVc44=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>>>>> "Jari" == Jari Ruusu <jariruusu@users.sourceforge.net>:
 Jari> Jan Rychter wrote: Do you mind doing a a quick grep:
 >>
 Jari> cd /path/to/your/kernel/source grep "Jari Ruusu"
 Jari> drivers/block/loop.c
 >>
 Jari> If you see my name there, your kerneli.org cryptoapi enabled
 Jari> kernel is running same loop code I wrote years ago. Those
 Jari> loop-jari-something patches that you find on the net, are just
 Jari> copies of old loop-AES code.
 >>
 >> No, it is not running this code. The code that works well for me is
 >> the external cryptoapi (as modules) with last update in Feb 2002.

 Jari> Then you are running loop that fails in few seconds using my
 Jari> tests.

I guess I am just lucky, because that hasn't failed me in years. I think
I can live with that for now.

 >> How do you get a file-backed encrypted filesystem to work under
 >> Linux 2.4.24?

Looking at the (lack of) answers to my question, I gather there is no
clear-cut answer, or rather that the answer is "you don't".

 Jari> Writable file backed loops received death sentence when GFP_NOFS
 Jari> was introduced to kernel, and they have been on death row since
 Jari> then. The best way is to set up partition backed loop using
 Jari> loop-AES. Mainline loop is still prone to deadlock, both file
 Jari> backed and device backed.

Is everyone aware of these issues?

And, just wondering -- if loop-AES works so much better, why hasn't it
been included in the kernel?

--J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAM9vYLth4/7/QhDoRAr3XAJ9yCh1UUyvZN8dS9yEx5RI2FdkiHgCgwJMs
dpNRCOT4YxqrJr6MmRmVgII=
=Ee5i
-----END PGP SIGNATURE-----
--=-=-=--

