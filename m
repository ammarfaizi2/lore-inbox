Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266295AbTABSTR>; Thu, 2 Jan 2003 13:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbTABSTQ>; Thu, 2 Jan 2003 13:19:16 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:24193 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266295AbTABSTP>;
	Thu, 2 Jan 2003 13:19:15 -0500
Date: Thu, 2 Jan 2003 13:26:40 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Adrian Bunk <bunk@fs.tum.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Linux v2.5.54
Message-ID: <20030102132640.GA328@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Adrian Bunk <bunk@fs.tum.de>, Jaroslav Kysela <perex@suse.cz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@holomorphy.com>
References: <20030102171803.GQ6114@fs.tum.de> <Pine.LNX.4.33.0301021827160.649-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0301021827160.649-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 06:31:08PM +0100, Jaroslav Kysela wrote:
> On Thu, 2 Jan 2003, Adrian Bunk wrote:
> 
> > On Wed, Jan 01, 2003 at 07:43:40PM -0800, Linus Torvalds wrote:
> > 
> > >...
> > > Summary of changes from v2.5.53 to v2.5.54
> > > ============================================
> > >...
> > > Jaroslav Kysela <perex@suse.cz>:
> > >   o PnP update
> > >...
> > 
> > FYI:
> > 
> > This change broke the compilation of drivers/ide/ide-pnp.c:
> 
> Yes, this code was not functional (although compilable). I've noted this 
> situation in my patch comment. We have to upgrade all old ISA PnP code to 
> the new PnP layer. It's better to fail with an error than silently ignore
> this situation (this will force more developers to update their parts).
>
> I'll update our ALSA code ASAP.
>
> 						Jaroslav
>

Zwane has released a patch to convert pnp-ide to the new APIs.  I'll send
it out soon but there are pnp ide problems, found in both 2.4 and 2.5, that
need to be resolved.  I believe a fix for them will also be out soon.  If 
anyone has questions about converting drivers feel free to contact me.

Adam
