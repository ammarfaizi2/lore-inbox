Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbTB0XSp>; Thu, 27 Feb 2003 18:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbTB0XSp>; Thu, 27 Feb 2003 18:18:45 -0500
Received: from daimi.au.dk ([130.225.16.1]:2281 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S267261AbTB0XSo>;
	Thu, 27 Feb 2003 18:18:44 -0500
Message-ID: <3E5E9F2F.532CB774@daimi.au.dk>
Date: Fri, 28 Feb 2003 00:28:47 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: jw schultz <jw@pegasys.ws>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030227092121.GG15254@pegasys.ws> <200302271251.h1RCpas29798@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> lrwxrwxrwx   1 root     root           12 Nov 12  2001 root -> /.share/root

Wouldn't it be best to keep /root on the root filesystem?
It is rarely large, and if you need to log in as root to
fix some mounting problem, I guess you want your home
directory.

> lrwxrwxrwx   1 root     root           11 Nov 12  2001 mnt -> /.local/mnt

What is the point in making mnt a local directory? All
it contains are some directories to serve as mountpoints.
I guess you are going to mount something on top of every
subdirectory in mnt anyway.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
