Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268856AbRHFQY2>; Mon, 6 Aug 2001 12:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268857AbRHFQYT>; Mon, 6 Aug 2001 12:24:19 -0400
Received: from lech.pse.pl ([194.92.3.7]:54923 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id <S268856AbRHFQYG>;
	Mon, 6 Aug 2001 12:24:06 -0400
Date: Mon, 6 Aug 2001 18:24:14 +0200
From: Lech Szychowski <lech.szychowski@pse.pl>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getty problems
Message-ID: <20010806182414.A29605@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010806142703.A25428@lech.pse.pl> <20010807003043.C23937@weta.f00f.org> <20010806154530.A26776@lech.pse.pl> <20010807020944.A24146@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010807020944.A24146@weta.f00f.org>
User-Agent: Mutt/1.3.20i
Organization: Polskie Sieci Elektroenergetyczne S.A.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     2.4.7-ac7:
>     ----------
[snip]
> 
> Are you use this kernel isn't devfs inflicted?

2.4.7-ac7 is compiled without devfs, 2.4.5 has devfs support
compiled in but - IMHO - not used:

$ cat /proc/filesystems | grep devfs
nodev   devfs

$ /sbin/lsmod 
Module                  Size  Used by
de4x5                  39440   2

lech7@nnet:~$ mount
/dev/sda6 on / type ext2 (rw)
/dev/sda7 on /var type ext2 (rw)
/dev/sda8 on /tmp type ext2 (rw)
/dev/sda9 on /usr/local/squid type ext2 (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /proc type proc (rw)

$ uname -r
2.4.5

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
