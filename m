Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVBIN5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVBIN5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 08:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVBIN5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 08:57:44 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:39112 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261822AbVBIN5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 08:57:43 -0500
Date: Wed, 9 Feb 2005 14:55:32 +0100 (CET)
From: Armin Schindler <armin@melware.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: developers@melware.de, isdn4linux@listserv.isdn4linux.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: RFC: [2.6 patch] Eicon: disable debuglib for modules
In-Reply-To: <20041220002225.GJ21288@stusta.de>
Message-ID: <Pine.LNX.4.61.0502091452480.12471@phoenix.one.melware.de>
References: <20041030072256.GH4374@stusta.de>
 <Pine.LNX.4.31.0410301343450.24225-100000@phoenix.one.melware.de>
 <20041220002225.GJ21288@stusta.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Adrian Bunk wrote:
> > > Is there a good reason why debuglib is enabled for modules?
> > 
> > Yes.
> > Without it, there would be no possibility to use the maintainance module
> > to debug the isdn/card/capi interaction.
> > 
> > > If not, I'd propose the patch below to disable it.
> > 
> > I have to disagree. This patch would disable a major feature of the
> > diva driver collection.
> 
> How do I enable this maintainance module in the kernel?

In the 'ISDN active card' 'Eicon' section you will find the option
  DIVA Maint driver support
which is only available as a module.
When the other diva drivers are compiled as modules too, they will provide
all trace data to the maint module.
The userspace tool 'divactrl' then retrieves the trace data according to
set trace masks.

Armin

