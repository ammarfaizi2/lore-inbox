Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVDEOGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVDEOGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVDEOGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:06:04 -0400
Received: from smtp11.wanadoo.fr ([193.252.22.31]:3494 "EHLO smtp11.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261748AbVDEOFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:05:45 -0400
X-ME-UUID: 20050405140543784.BF8FC1C000A0@mwinf1107.wanadoo.fr
Date: Tue, 5 Apr 2005 16:02:21 +0200
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Humberto Massa <humberto.massa@almg.gov.br>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050405140221.GB24361@pegasos>
References: <h-GOHD.A.KL.s2aUCB@murphy> <42527E89.4040506@almg.gov.br> <425281B0.9080909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <425281B0.9080909@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 08:16:48AM -0400, Jeff Garzik wrote:
> Humberto Massa wrote:
> >But, the question made here was a subtler one and you are all biting 
> >around the bush: there *are* some misrepresentations of licenses to the 
> >firmware blobs in the kernel (-- ok, *if* you consider that hex dumps 
> >are not source code). What Sven asked was: "Hey, can I state explicitly 
> >the distribution state in the source files, by means of adding some 
> >comments?".
> 
> >I think even a clarification "this firmware hexdump is considered to be 
> >the source code, and it's GPL'd" would do, but I must put my asbestos 
> >suit everytime I say it. :-)
> 
> We do not add comments to the kernel source code which simply state the 
> obvious.

The only thing here is that it has to be obvious not only to you, but to the
judge too :)

In this case, it is not comments, but proper copyright attribution, which was
added in the tg3.c case since the first checkin :

/*
 * tg3.c: Broadcom Tigon3 ethernet driver.
 *
 * Copyright (C) 2001, 2002, 2003, 2004 David S. Miller (davem@redhat.com)
 * Copyright (C) 2001, 2002, 2003 Jeff Garzik (jgarzik@pobox.com)
 * Copyright (C) 2004 Sun Microsystems Inc.
 *
 * Firmware is:
 *      Copyright (C) 2000-2003 Broadcom Corporation.
 */

The firmware part was not present in the original checkin you did in 2002.
Adding something about the licencing status of it would be enough.

Or even adding some comment in the toplevel COPYING file saying that firmware
blobs come under their own licence or something such, and then listing all the
firmware blobs and their licencing condition in a separate toplevel file would
be enough.

Friendly,

Sven Luther

