Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTKCK2k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 05:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTKCK2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 05:28:40 -0500
Received: from b107150.adsl.hansenet.de ([62.109.107.150]:29313 "EHLO ds666")
	by vger.kernel.org with ESMTP id S261965AbTKCK2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 05:28:39 -0500
Message-ID: <3FA62DD4.1020202@portrix.net>
Date: Mon, 03 Nov 2003 11:28:36 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Clock skips (?) with 2.6 and games
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I'm experiencing skips in games like q3demo and enemy territory on a
dual xeon p4. That means, if I'm walking around, about every 2-3 seconds
I'm skipping a bit of the way. It seems that the clock is running too
slow and the games are trying to catch up every x seconds with the
system time.
System is running 2.6.0-test9-mm1. This effect does not show with
2.4.23pre6aa3, though there are only two processors displayed. Is this
normal? Judging from the temperature sensors that is not just one
processor with its sibling but really the two physical processors. Is
there any way with 2.4 to show all 4 processors?
I've tried booting 2.6 with nosmp, but that results in most interrupts
not working anymore.
What can I try to get test9 working properly?

Thanks,

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/pi3ULqMJRclVKIYRAkORAJ9foIw7SyrGuWzUn1FmkW+uAw3iUwCfVDFm
KfPZTA8XKGLqIc+53z7oQmE=
=0M+7
-----END PGP SIGNATURE-----

