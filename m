Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266365AbUHBJXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUHBJXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 05:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUHBJXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 05:23:45 -0400
Received: from snota.svorka.net ([194.19.72.11]:60045 "HELO snota.svorka.net")
	by vger.kernel.org with SMTP id S266365AbUHBJXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 05:23:43 -0400
Message-ID: <410E0816.6020903@svorka.net>
Date: Mon, 02 Aug 2004 11:23:34 +0200
From: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <eldiablo@svorka.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040705)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org>
In-Reply-To: <20040802015527.49088944.akpm@osdl.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:

| - Added Con's staircase CPU scheduler.
|
| This will probably have to come out again because various people
| are still fiddling with the CPU scheduler.  But my feeling here is
| that the current 1st-gen CPU scheduler has been tweaked as far as
| it can go and is still not 100% right.  It is time to start
| thinking about a new design which addresses the requirements and
| current problems by algorithmic means rather than by tweaking.
| Removing over 300 lines from the scheduler is a good sign.
|
| Feedback on this patch is sought.
|
I'm glad you added staircase, I've had better experiences with
staircase than the one which was mainstream before, I don't have any
actual timings on it, but it felt more responsive under heavier
load(Compiling much, listening to music, browsing...). :)

- --
Espen Fjellvær Olsen
eldiablo@svorka.net
Norway
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBDggWibTL5aHQf7URAmwvAJ46i+5OpkIQp4BtYt2xQScje5hmbgCfXjeF
a9Q46GSRh9YWtp2lfVay1IY=
=PlKC
-----END PGP SIGNATURE-----

