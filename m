Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUEQRgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUEQRgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUEQRgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:36:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:49606 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261984AbUEQRfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:35:39 -0400
Date: Mon, 17 May 2004 10:35:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: norberto+linux-kernel@bensa.ath.cx, linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.6 breaks kmail (nfs related?)
Message-Id: <20040517103502.6b84db26.akpm@osdl.org>
In-Reply-To: <20040517001431.7b4d8cda.akpm@osdl.org>
References: <200405131411.52336.amann@physik.tu-berlin.de>
	<200405170335.42754.norberto+linux-kernel@bensa.ath.cx>
	<20040517001431.7b4d8cda.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Norberto Bensa <norberto+linux-kernel@bensa.ath.cx> wrote:
> >
> > Well, I'm getting this with kcalc after upgrading to 2.6.6-mm3:
> > 
> >  $ kcalc
> >  KCrash: Application 'kcalc' crashing...
> > 
> >  strace shows lots of 
> >  ...
> >  close(1002)                             = -1 EBADF (Bad file descriptor)
> >  close(1003)                             = -1 EBADF (Bad file descriptor)
> >  close(1004)                             = -1 EBADF (Bad file descriptor)
> >  close(1005)                             = -1 EBADF (Bad file descriptor)
> >  ...
> 
> Send the whole thing, please: `strace -f -o log kcalc', and send `log'.  If
> it's too big to post please mail it to me direct and I'll stick it on a
> public server.
> 

Norberto's strace log is at
http://www.zip.com.au/~akpm/linux/patches/stuff/log.txt
