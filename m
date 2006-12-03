Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758154AbWLCRbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758154AbWLCRbP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 12:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758219AbWLCRbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 12:31:15 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:61137 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1758154AbWLCRbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 12:31:15 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 3 Dec 2006 12:27:43 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: replace "kmalloc+memset" with kzalloc in kernel/
 dir
In-Reply-To: <20061203092415.f68bfb87.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0612031227270.4925@localhost.localdomain>
References: <Pine.LNX.4.64.0612030829400.3793@localhost.localdomain>
 <20061203092415.f68bfb87.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.541, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2006, Randy Dunlap wrote:

> On Sun, 3 Dec 2006 08:31:50 -0500 (EST) Robert P. J. Day wrote:
>
> >
> >   Replace kmalloc()+memset() combination with kzalloc().
> >
> > Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> >
> > ---
> >
> >  auditfilter.c |    3 +--
> >  futex.c       |    4 +---
> >  kexec.c       |    3 +--
> >  3 files changed, 3 insertions(+), 7 deletions(-)
>
> Please use diffstat -p1 -w70 as indicated in
> Documentation/SubmittingPatches.

whoops, sorry.  i hadn't noticed that before.  should i resubmit that
patch with the correct diffstat formatting?

rday
