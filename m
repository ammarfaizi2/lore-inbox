Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265478AbSKAC4Z>; Thu, 31 Oct 2002 21:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbSKAC4Z>; Thu, 31 Oct 2002 21:56:25 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:16524 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265478AbSKAC4X>; Thu, 31 Oct 2002 21:56:23 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 31 Oct 2002 19:12:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: RE: Unifying epoll,aio,futexes etc. (What I really want from epol
 l)
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CAC8B6@orsmsx116.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0210311904070.972-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Perez-Gonzalez, Inaky wrote:

>
> > everything easier. I don't really see futex creation/destroy
> > as an high
> > frequency event that might be suitable for optimization.
> > Usually you have
> > your own set of resources to be "protected" and in 95% of
> > cases you know
> > those resources from the beginning.
>
> If with inititialization you mean taking the slow path ...

No, I mean the association between a futex address to a file. That is what
you have to do to use a futex with epoll ( 2.5.46 hopefully, if QA is
passed ).



- Davide



