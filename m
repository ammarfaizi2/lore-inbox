Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262386AbSJEQdx>; Sat, 5 Oct 2002 12:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262391AbSJEQdw>; Sat, 5 Oct 2002 12:33:52 -0400
Received: from AGrenoble-101-1-4-253.abo.wanadoo.fr ([217.128.202.253]:20882
	"EHLO elessar.linux-site.net") by vger.kernel.org with ESMTP
	id <S262386AbSJEQdv>; Sat, 5 Oct 2002 12:33:51 -0400
Message-ID: <3D9F195C.7010308@wanadoo.fr>
Date: Sat, 05 Oct 2002 18:54:52 +0200
From: FD Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Andre Costa <brblueser@uol.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: IDE subsystem issues with 2.4.1[89] [REVISITED]
References: <20021005114725.3af9c194.brblueser@uol.com.br>	<1033833579.4103.2.camel@irongate.swansea.linux.org.uk> <20021005131823.676c1bcc.brblueser@uol.com.br>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andre Costa wrote:
| Hi Alan, thks for replying.
|
| So, this basically means 2.4.20 final will contain all improvements on
| the -ac branch plus the critical backports from 2.5.x? Will this be the
| cure to all my probls? ;)
|
| Seriously speaking: do you have confirmartion that the IDE updates on
| the -ac branch fix the cd audio ripping timeouts? Do you want me to try
| it out? <newbie>If so, can I simply apply the 2.4.20-pre8-ac3 on top of
| my vanilla 2.4.19 source code or is any other patch required?</newbie>

Apply 2.4.20pre8 (found in
ftp://ftp.kernel.org/pub/linux/kernel/v2.4/testing ) on top of
2.4.19 then 2.4.20pre8ac3 (found in
ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/ )

2.4.20pre8ac3 is running here, no problems.

| Again, thks for looking into this.
|
| Best,
|
| Andre
|
| On 05 Oct 2002 16:59:39 +0100
| Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
|
|
|>On Sat, 2002-10-05 at 14:47, Andre Costa wrote:
|>
|>>I know this is a known issue, and you guys are working on it; I also
|>>know many changes to IDE subsystem have been backported from 2.5.x
|>>series, and 2.4.20pre* already reflect some (all?) of them. I don't
|>>want to rush things, I was just curious to know the current status
|>>regarding these IDE issues.
|>
|>2.5 has most but not all of the IDE updates in 2.4-ac. 2.4 vanilla has
|>basically old IDE code but with some small PCI layer fixes backported
|>that deal with all the i845G bios mess


- --

F. CAMI
- ----------------------------------------------------------
~ "To disable the Internet to save EMI and Disney is the
moral equivalent of burning down the library of Alexandria
to ensure the livelihood of monastic scribes."
~              - John Ippolito (Guggenheim)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9nxlbuBGY13rZQM8RAtFqAJ90IW/Y033KlWlrqzFKuf7+wnwb9QCfYk50
YanShQveyNVSROpvTgzaFoE=
=c+wj
-----END PGP SIGNATURE-----

