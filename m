Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBCHqB>; Sat, 3 Feb 2001 02:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbRBCHpw>; Sat, 3 Feb 2001 02:45:52 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32266 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129028AbRBCHpd>; Sat, 3 Feb 2001 02:45:33 -0500
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
To: jamagallon@able.es (J . A . Magallon)
Date: Sat, 3 Feb 2001 07:46:06 +0000 (GMT)
Cc: reiser@namesys.com (Hans Reiser), alan@redhat.com (Alan Cox),
        mason@suse.com (Chris Mason), kas@informatics.muni.cz (Jan Kasprzak),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        yura@yura.polnet.botik.ru (Yury Yu . Rupasov)
In-Reply-To: <20010203004003.A2962@werewolf.able.es> from "J . A . Magallon" at Feb 03, 2001 12:40:03 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OxOb-0007yA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please, do not do so. That depends on the PACKAGE name and version, and there
> is no standard way of versioning a patched gcc.
> The -54 is a RH'ism, for example Mandrake Cooker includes patches from
> different sources, and gcc is versioned like
> 
> werewolf:~# rpm -q gcc
> gcc-2.96-0.33mdk

Thats fine. It doesnt matcht he problem one. If you know which are the problem
ones on Mandrake add those too

You can also use


if [ -e /bin/rpm ]; then
	if [ -e /etc/redhat-release ]; then




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
