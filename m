Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbULTHzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbULTHzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 02:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbULTHub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:50:31 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:36078 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261474AbULTGoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:44:00 -0500
Date: Mon, 20 Dec 2004 07:41:52 +0100 (CET)
From: Armin Schindler <armin@melware.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: isdn4linux@listserv.isdn4linux.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       developers@melware.de
Subject: Re: RFC: [2.6 patch] Eicon: disable debuglib for modules
In-Reply-To: <20041220002225.GJ21288@stusta.de>
Message-ID: <Pine.LNX.4.61.0412200731170.10821@phoenix.one.melware.de>
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

The option 'DIVA Maint driver support' enables this module.
When the module is loaded, all diva modules provide trace logs to that 
module. Using the user-space utility 'divactrl' you can set e.g. trace masks 
and read the messages.

Armin
