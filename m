Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265391AbSJPRVs>; Wed, 16 Oct 2002 13:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265392AbSJPRVs>; Wed, 16 Oct 2002 13:21:48 -0400
Received: from AGrenoble-101-1-3-230.abo.wanadoo.fr ([193.253.251.230]:13286
	"EHLO elessar.linux-site.net") by vger.kernel.org with ESMTP
	id <S265391AbSJPRVq>; Wed, 16 Oct 2002 13:21:46 -0400
Message-ID: <3DADA58C.2020009@wanadoo.fr>
Date: Wed, 16 Oct 2002 19:44:44 +0200
From: FD Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: mcuss@cdlsystems.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
References: <077901c27538$ef71b4a0$2c0e10ac@frinkiac7>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mark Cuss wrote:
| Hello all
|
| I'm working with a new Dell Poweredge 4600 Server with Dual CPUs.
However,
| Linux reports that it sees 4 CPUs...  I have opened the thing to see
if Dell
| gave me 2 extras for free, but no luck:  Attached is /proc/cpuinfo.
|
| I've tried the RedHat 8.0 stock kernel, as well as a freshly compiled
2.4.19
| but both exhibit the same behavior.
|
| The specifics on the machine:
|
| Dual Xeon 2.2 GHz CPUs (512 k L2 cache)
| 2 Gigs DDR RAM
| The chipset is a ServerWorks CMIC-HE (see attached lspci for complete
| listing).
|
| Has anyone else seen this behavior?  The only other SMP machine I have
is an
| older Dell server with Dual 1 GHz coppermines, and it reports 2 CPUs...
|
| Any information or advice is greatly appreciated...
|
| Thanks in Advance,
|
| Mark

What you're seeing there is HyperThreading in action...

|
| Mark Cuss
| Real Time Systems Analyst
| CDL Systems Ltd.
| Suite 230
| 3553 - 31 Street NW
| Calgary, Alberta
| T2L 2K7
|
| Phone (403) 289-1733 extension 226
| Email:  mcuss@cdlsystems.com
| URL: www.cdlsystems.com


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

iD8DBQE9raWMuBGY13rZQM8RAoHMAKCE7vuPRls9Qx8tn/n8jkO6rivxjgCgsTfQ
6vyXt5MXJFQT+zvVzxObQsA=
=7Kkn
-----END PGP SIGNATURE-----

