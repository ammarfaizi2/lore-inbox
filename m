Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVFWTXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVFWTXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbVFWTQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:16:17 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:13220 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262715AbVFWTPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:15:21 -0400
Message-Id: <200506231913.j5NJD1IY030869@laptop11.inf.utfsm.cl>
To: Adrian Bunk <bunk@stusta.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@muc.de>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Add removal schedule of register_serial/unregister_serial to appropriate file 
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Thu, 23 Jun 2005 16:03:16 +0200." <20050623140316.GH3749@stusta.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 23 Jun 2005 15:13:01 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 23 Jun 2005 15:13:02 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> On Thu, Jun 23, 2005 at 02:23:35PM +0100, Russell King wrote:
> >...
> > However, wouldn't it be a good idea if this file was ordered by "when" ?
> > A quick scan of the file reveals a couple of overdue/forgotten items
> > (maybe they happened but the entry in the file got missed?):
> >...
> > What:   register_ioctl32_conversion() / unregister_ioctl32_conversion()
> > When:   April 2005
> >...
> 
> The removal (including the removal of the feature-removal-schedule.txt 
> entry) is already in -mm.

Perhaps they should be moved to a REMOVED file, with the date (and version)
the patch went in? For future generations who wonder when something was
axed...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
