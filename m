Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932724AbVLBLJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbVLBLJJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 06:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbVLBLJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 06:09:09 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:52973 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932724AbVLBLJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 06:09:08 -0500
Date: Fri, 2 Dec 2005 12:08:07 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: JaniD++ <djani22@dynamicweb.hu>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc3: adduser: unable to lock password file
Message-ID: <20051202110805.GA7224@stiffy.osknowledge.org>
References: <016c01c5f6cc$0e28e6d0$0400a8c0@dcccs> <1133481721.9597.37.camel@lade.trondhjem.org> <00f801c5f72e$df2e58c0$0400a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f801c5f72e$df2e58c0$0400a8c0@dcccs>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc3-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* JaniD++ <djani22@dynamicweb.hu> [2005-12-02 11:55:09 +0100]:

> Hi,
> 
> ----- Original Message ----- 
> From: "Trond Myklebust" <trond.myklebust@fys.uio.no>
> To: "JaniD++" <djani22@dynamicweb.hu>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Friday, December 02, 2005 1:02 AM
> Subject: Re: 2.6.15-rc3: adduser: unable to lock password file
> 
> 
> > On Thu, 2005-12-01 at 23:47 +0100, JaniD++ wrote:
> > > Hello, list,
> > >
> > > I get this after upgrade from 2.6.14.2
> > >
> > > [root@dy-xeon-1 etc]# adduser someuser
> > > adduser: unable to lock password file
> > > [root@dy-xeon-1 etc]#
> > >
> > > I use nfsroot!
> >
> > I'm seeing no trouble with locking on 2.6.15-rc3 (with or without the
> > -onolock option). Could you please use 'strace' to get a dump of what
> > adduser is failing on?
> 
> OK, i will try it, if i can.... (this is a productive online system, maybe
> next reboot)

I'd rather suggest to _not_ run -rc kernels on productive systems. :)

Marc
