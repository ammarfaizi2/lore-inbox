Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTLUPmj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 10:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTLUPmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 10:42:39 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:40197 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263378AbTLUPmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 10:42:37 -0500
Date: Sun, 21 Dec 2003 16:42:27 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Octave <oles@ovh.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Peter Zaitsev <peter@mysql.com>, linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031221154227.GB1323@alpha.home.local>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local> <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221150312.GJ25043@ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221150312.GJ25043@ovh.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 04:03:12PM +0100, Octave wrote:
 
> # ps auxw | grep -v "0  0.0"
> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> mysql    26958  0.0 14.0 275000 144972 ?     S    Dec19   2:09 /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --user=mysql --
> mysql    27004  0.0 14.0 275000 144972 ?     S    Dec19   2:28 /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --user=mysql --
> mysql    27005  0.0 14.0 275000 144972 ?     S    Dec19   2:03 /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --user=mysql --
> root      9621  0.0  0.1  6316 1860 ?        S    01:02   0:00 /usr/sbin/sshd
> root      9631  0.0  0.1  2500 1352 pts/0    S    01:02   0:00 -bash
> root      9683  0.0  0.1  6276 1844 ?        S    13:47   0:00 /usr/sbin/sshd
> root      9707  0.0  0.1  2504 1356 pts/2    S    13:47   0:00 -bash
> postfix  29728  0.0  0.1  3508 1184 ?        S    15:45   0:00 pickup -l -t fifo -u
> mysql     7341  0.0 14.0 275000 144972 ?     S    15:59   0:00 /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --user=mysql --
> root      7347  0.0  0.1  2504 1356 pts/2    R    15:59   0:00 -bash
> 
> There is nothing to take 1Go of RAM.

Octave,

one of my collegues had a server which occasionally crashed at night with
mysql taking all the memory. I think it was with an old 2.4.18 kernel. He
finally reinstalled all the machine and it never happened anymore. So
eventhough it works for you with 2.4.22, perhaps 2.4.23 triggers a mysql
bug which is fixed in more recent releases ?

Cheers,
Willy

