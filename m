Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVHXHcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVHXHcW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVHXHcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:32:22 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:16522 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1750703AbVHXHcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:32:22 -0400
From: djani22@dynamicweb.hu
Message-ID: <039401c5a87d$e64e59c0$0400a8c0@LocalHost>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: <linux-kernel@vger.kernel.org>
References: <03b601c5a804$305d8ce0$0400a8c0@LocalHost> <1124840177.10110.3.camel@lade.trondhjem.org>
Subject: Re: message: do_vfs_lock: VFS is out of sync with lock manager!
Date: Wed, 24 Aug 2005 09:17:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Trond Myklebust" <trond.myklebust@fys.uio.no>
To: <info@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, August 24, 2005 1:36 AM
Subject: Re: message: do_vfs_lock: VFS is out of sync with lock manager!


> ty den 23.08.2005 Klokka 19:00 (+0200) skreiv info@netcenter.hu:
> > Hello list, developers!
> >
> > I have seriously get this message:
> >
> > [43124719.930000] do_vfs_lock: VFS is out of sync with lock manager!
> > [43124720.940000] do_vfs_lock: VFS is out of sync with lock manager!
> > [43124721.950000] do_vfs_lock: VFS is out of sync with lock manager!
> > [43124722.960000] do_vfs_lock: VFS is out of sync with lock manager!
> > [43124723.970000] do_vfs_lock: VFS is out of sync with lock manager!
> >
>
> The above is a lockd error that states that the VFS is failing to track
> your NFS locks correctly. Do you have a testcase (or can you at least
> describe what applications you think might be using NFS locking on your
> system)?

I get this message on 13-rc3, but more often on rc6!

I have use a web server that servers files from GNBD to Internet.
In this service the NFS is used only logging. ( | filtered with cronolog)
- I think, there is no NFS-lock in here

The another tasks:
Sendmail.
-I think the problem is here!

Sometimes the system is hangs when high NFS traffic eg. when big mail is
come...
I get some strange kernel message in logs, but the backtrace is shows: the
gnbd has a bug.
But I don't think so!
I _never_ get these strange messages before rc6!
If you ask, I can send these too...

more:
named,pop3,fure-ftpd (gnbd-only), imap

My system is very special.
This is a FREE web storage.
I can help to test / debug.
I do it too on netdev, raid lists.

What can I help?

Thanks

Janos




>
> Cheers,
>   Trond

