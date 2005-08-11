Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVHKS5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVHKS5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVHKS5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:57:11 -0400
Received: from pat.uio.no ([129.240.130.16]:28879 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932365AbVHKS5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:57:09 -0400
Subject: Re: fcntl(F_GETLEASE) semantics??
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Heikki Orsila <shd@modeemi.cs.tut.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Chubb <peterc@gelato.unsw.edu.au>
In-Reply-To: <20050811184144.GE31158@jolt.modeemi.cs.tut.fi>
References: <20050811184144.GE31158@jolt.modeemi.cs.tut.fi>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 14:56:59 -0400
Message-Id: <1123786619.7095.47.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.072, required 12,
	autolearn=disabled, AWL 0.93, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 11.08.2005 Klokka 21:41 (+0300) skreiv Heikki Orsila:
> Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
> > if (fcntl(fd, F_SETLEASE, F_RDLCK) == -1)
> >     fail;
> 
> Is that something inotify can do? If so, then should F_SETLEASE/GETLEASE
> be deprecated for future? F_SETLEASE is Linux specific, and inotify is
> generally more useful. It looks like inotify could be used to detected 
> changes in any file.

inotify does not give you synchronous notification. It just tells you
something has happened after the fact. Not the same thing at all.

Cheers,
  Trond

