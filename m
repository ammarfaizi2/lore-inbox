Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUHZDOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUHZDOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 23:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUHZDOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 23:14:14 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:16511 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266867AbUHZDOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 23:14:08 -0400
Message-ID: <412D557B.1090500@triplehelix.org>
Date: Wed, 25 Aug 2004 20:14:03 -0700
From: Joshua Kwan <joshk@triplehelix.org>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc1
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>	<412CDFEE.1010505@triplehelix.org>	<20040825203206.GS5824@sunbeam.de.gnumonks.org> <20040825164401.12259308.davem@redhat.com>
In-Reply-To: <20040825164401.12259308.davem@redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David S. Miller wrote:
| And adding an export of ip_nat_find_helper (ie. without the two underscore
| prefix).  Why?
|
| If we need to export one, then we need to export both.

Exporting both was the only way I could get it to compile. On the other
hand, the fix seems to have worked without any further repercussions.

- --
Joshua Kwan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQS1Ve6OILr94RG8mAQLEIhAAqzFjNVxhFmCvj2nYwbMa8l3I7SJdzrFf
ge1Rua8ktQMOemVebWuReQLsAYm70MCS/JJujAk25raZVTNHtzazNd/bJ03pbjnO
xcUVt+JK1OzWJcoQYvzJRhDGzrY7GHn/93P0DK5+ROSYBAUVzBT6rO67cJBpsM7V
t4PVpgMFVpw/sP53sR3uyUSotSPVIHrXnsplyiAvCxhz+y14zwRI9QEhKmRVzjhb
PlJBooRMmB0rb6l1JATAp3EVpJsA6CBczMd0nsQV478r05OVZkkWcTHT5IlFv2Dr
k3tDotHKK0FQuqDHULQeuqVWP9Sl35Zp/hEzZQNjywptC0LG7e3x21N/BahuqqaJ
w+CkunMK4QkmizJNgMHC/CDeaJP1ZlhV9G0V7pTwojjatO4TmQFEtNbaVhaQziCv
0wx2qeM4nASFyiXwcWR1WSZ4K37NRVYNPlpeAo9QKaW54HZ/tar44bqAMfuAtaqP
yBNxAT58daPrOT2/ePnbzEMReueMiaWDBoJuzoHxhZ6thbubviYT0iitHKagckeU
JKKZsKi9t4SJydDZ2pjbFx9bzO4EC6sgjB7YT/1N6ulubu8DFsZYNEfax3n8NgNX
zmeaVYD/ezUjE5dKXU45PB0KhySDx396x2nh5kcbXPl0NcB8oRX5Hrh/KgOlEbEa
allwXmgYrYA=
=d+1T
-----END PGP SIGNATURE-----
