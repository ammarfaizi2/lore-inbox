Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279934AbRKSQUV>; Mon, 19 Nov 2001 11:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279963AbRKSQUM>; Mon, 19 Nov 2001 11:20:12 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:27909 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S279934AbRKSQT7>; Mon, 19 Nov 2001 11:19:59 -0500
Message-Id: <200111191619.fAJGJBu8018551@pincoya.inf.utfsm.cl>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature? 
In-Reply-To: Message from vda <vda@port.imtp.ilyichevsk.odessa.ua> 
   of "Mon, 19 Nov 2001 17:03:40 -0000." <01111917034005.00817@nemo> 
Date: Mon, 19 Nov 2001 13:19:10 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda <vda@port.imtp.ilyichevsk.odessa.ua> said:

[...]

> Do you have even a single dir on your boxes with r!=x?

Directories /dev, /lib, /bin, /etc under FTP home are --x. I'd do the same
with cgi-bin et al for WWW...

Some FTP sites (f.ex. ftp.sendmail.org) have limited distribution
prereleases under an unreadable directory (--x).

-wx is used for anonymous uploading under FTP

It certainly has its uses. If you wanted to _really_ lock down a box, you'd
start by doing the same --x game for some critical directories.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
