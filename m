Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVHWXga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVHWXga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVHWXga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:36:30 -0400
Received: from pat.uio.no ([129.240.130.16]:19878 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751144AbVHWXg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:36:29 -0400
Subject: Re: message: do_vfs_lock: VFS is out of sync with lock manager!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: info@netcenter.hu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <03b601c5a804$305d8ce0$0400a8c0@LocalHost>
References: <03b601c5a804$305d8ce0$0400a8c0@LocalHost>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 19:36:17 -0400
Message-Id: <1124840177.10110.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.321, required 12,
	autolearn=disabled, AWL 1.68, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 23.08.2005 Klokka 19:00 (+0200) skreiv info@netcenter.hu:
> Hello list, developers!
> 
> I have seriously get this message:
> 
> [43124719.930000] do_vfs_lock: VFS is out of sync with lock manager!
> [43124720.940000] do_vfs_lock: VFS is out of sync with lock manager!
> [43124721.950000] do_vfs_lock: VFS is out of sync with lock manager!
> [43124722.960000] do_vfs_lock: VFS is out of sync with lock manager!
> [43124723.970000] do_vfs_lock: VFS is out of sync with lock manager!
> 

The above is a lockd error that states that the VFS is failing to track
your NFS locks correctly. Do you have a testcase (or can you at least
describe what applications you think might be using NFS locking on your
system)?

Cheers,
  Trond

