Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265967AbUFIUlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265967AbUFIUlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUFIUl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:41:27 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:27520 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265958AbUFIUlU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:41:20 -0400
Subject: Re: 2.6.X File locking on NFS stil broken
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <20040609191758.GA29969@puettmann.net>
References: <20040609191758.GA29969@puettmann.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086813672.4078.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 16:41:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På on , 09/06/2004 klokka 15:17, skreiv Ruben Puettmann:
>                 hello,
> 
> 
> I have a big iproblem with the nfs file locking on some 2.6 er kernel 
> 
> Kernel Server: 2.4.9
> Kernel Client: 2.6.7-rc3-bk2
>                2.6.6-rc3-mm2
>                2.6.5
<snip>
> This little testscript I  used ( got it from a friend):

That script works fine for me: I haven't seen any hangs on locking in
any of the 2.6 series kernels so far.

What does 'rpcinfo -p' show on the client and server?

Cheers,
  Trond
