Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVAODEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVAODEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 22:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVAODEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 22:04:46 -0500
Received: from evtexc09.relay.danahertm.com ([129.196.229.156]:39218 "EHLO
	evtexc09.relay.danahertm.com") by vger.kernel.org with ESMTP
	id S262112AbVAODEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 22:04:39 -0500
Date: Fri, 14 Jan 2005 19:04:51 -0800 (PST)
From: David Dyck <david.dyck@fluke.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Steffen Moser <lists@steffen-moser.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.29-rc2
In-Reply-To: <Pine.LNX.4.51.0501141853270.222@dd.tc.fluke.com>
Message-ID: <Pine.LNX.4.51.0501141903040.223@dd.tc.fluke.com>
References: <20050112151334.GC32024@logos.cnet> <20050114225555.GA17714@steffen-moser.de>
 <20050114231712.GH3336@logos.cnet> <Pine.LNX.4.51.0501141853270.222@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Jan 2005 03:08:54.0937 (UTC) FILETIME=[8C112090:01C4FAAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005 at 18:58 -0800, David Dyck <david.dyck@fluke.com> wrote:

> On Fri, 14 Jan 2005 at 21:17 -0200, Marcelo Tosatti <marcelo.tosatti@cyclad...:
>
> > David, this also fix your problem.
>
>
> Sorry, no
>
> I tried your patch to drivers/char/tty_io.c
> (using EXPORT_SYMBOL instead of EXPORT_SYMBOL_GPL)
>
>  heading back to 2.4.29-pre2...
>      David

I noticed when booting 2.4.29-pre2 that I getting
other unresolved symbols

$ cd /lib/modules/2.4.29-pre2/kernel/fs/isofs
$ sudo insmod isofs.o

isofs.o: unresolved symbol zlib_inflate_workspacesize_Rce5ac24f
isofs.o: unresolved symbol zlib_inflateEnd_R9ef45f92
isofs.o: unresolved symbol zlib_inflate_R64cf8602
isofs.o: unresolved symbol zlib_inflateInit__R456e911d

I don't know if these are related
