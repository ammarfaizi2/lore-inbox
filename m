Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbTA1BgQ>; Mon, 27 Jan 2003 20:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTA1BgQ>; Mon, 27 Jan 2003 20:36:16 -0500
Received: from [208.0.185.14] ([208.0.185.14]:27666 "EHLO ncbdc.bbs.com")
	by vger.kernel.org with ESMTP id <S264739AbTA1BgP>;
	Mon, 27 Jan 2003 20:36:15 -0500
Message-ID: <057889C7F1E5D61193620002A537E8690B4387@NCBDC>
From: Stanley Yee <SYee@snapappliance.com>
To: "'Gianni Tedesco'" <gianni@ecsc.co.uk>,
       Stanley Yee <SYee@snapappliance.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: sendfile support in linux
Date: Mon, 27 Jan 2003 17:45:20 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to find out more about sendfile(2).  So far, from what I've
gathered, it sounds like the requirements for it are (please correct me if
I'm wrong):

1.  A kernel with sendfile support (i.e. 2.4.X)
2.  A network card capable of doing the TCP checksum in the hardware
3.  The application must support sendfile 

Do you know what applications support zerocopy (sendfile)?  I noticed that a
zerocopy NFS patch was added to the 2.5.x tree.  Does the 2.4.X NFS daemon
support zerocopy?  Does samba support zerocopy and if so what version?

Only me,
Stanley Yee

-----Original Message-----
From: Gianni Tedesco [mailto:gianni@ecsc.co.uk]
Sent: Thursday, January 23, 2003 1:14 AM
To: Stanley Yee
Cc: Linux Kernel Mailing List
Subject: Re: Zero copy in 2.4 kernels


On Wed, 2003-01-22 at 01:48, Stanley Yee wrote:
> Is the zero copy function enabled by default in the 2.4.X kernels?  If so
> which kernel version and what do I need to do to enable it?  Thanks for
your
> time.

sendfile(2) does zero-copy writes from files to sockets, works on any
version of 2.4 AFAIK.

HTH

-- 
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D
