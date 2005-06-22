Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVFVWEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVFVWEo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVFVWEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:04:15 -0400
Received: from mail.linicks.net ([217.204.244.146]:27657 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262538AbVFVVyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:54:52 -0400
From: Nick Warne <nick@linicks.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Problem compiling 2.6.12
Date: Wed, 22 Jun 2005 22:53:47 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, George Kasica <georgek@netwrx1.com>
References: <200506222037.17738.nick@linicks.net> <20050622213038.GA3749@stusta.de>
In-Reply-To: <20050622213038.GA3749@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506222253.47777.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 June 2005 22:30, Adrian Bunk wrote:
> On Wed, Jun 22, 2005 at 08:37:17PM +0100, Nick Warne wrote:
> > George Kasica wrote:
> > > Tried that here and got not much farther...here's the error:
> > >
> > > [root@eagle linux]# make bzImage
> > >    CHK     include/linux/version.h
> > >    SPLIT   include/linux/autoconf.h -> include/config/*
> > >    HOSTCC  scripts/mod/sumversion.o
> > > In file included from /usr/include/linux/errno.h:4,
> >
> > That last line looks wrong...  I think you may have symlinks linking to
> > other older kernel header stuff.
> >...
>
> No, it looks correct.
>
> That's the copy of linux/errno.h shipped with glibc and that's correct
> when using HOSTCC.

Is it?  I thought kernel didn't care what Glibc or what kernel headers you had 
(that is system requirement) - it is automous.  Isn't HOSTCC explicitly just 
what compiler you have?

I build regular in other places... my latest builds are on /mnt/hdb/

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
