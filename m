Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVLCNGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVLCNGG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 08:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVLCNGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 08:06:05 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:27015 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751252AbVLCNGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 08:06:05 -0500
Message-ID: <00e501c5f809$99c70bc0$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: <linux-kernel@vger.kernel.org>
References: <016c01c5f6cc$0e28e6d0$0400a8c0@dcccs> <1133481721.9597.37.camel@lade.trondhjem.org>
Subject: Re: 2.6.15-rc3: adduser: unable to lock password file
Date: Sat, 3 Dec 2005 14:00:52 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

----- Original Message ----- 
From: "Trond Myklebust" <trond.myklebust@fys.uio.no>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, December 02, 2005 1:02 AM
Subject: Re: 2.6.15-rc3: adduser: unable to lock password file


> On Thu, 2005-12-01 at 23:47 +0100, JaniD++ wrote:
> > Hello, list,
> >
> > I get this after upgrade from 2.6.14.2
> >
> > [root@dy-xeon-1 etc]# adduser someuser
> > adduser: unable to lock password file
> > [root@dy-xeon-1 etc]#
> >
> > I use nfsroot!
>
> I'm seeing no trouble with locking on 2.6.15-rc3 (with or without the
> -onolock option). Could you please use 'strace' to get a dump of what
> adduser is failing on?

Here is the strace-s output:     (20KB)
http://download.netcenter.hu/bughunt/20051203/adduser.log

This problem is always on on 2.6.15-rc3, and newer on 2.6.14.2

Cheers,
Janos

>
> Cheers,
>  Trond
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

