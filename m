Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWJQSAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWJQSAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWJQSAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:00:15 -0400
Received: from solarneutrino.net ([66.199.224.43]:9742 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1750708AbWJQSAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:00:13 -0400
Date: Tue, 17 Oct 2006 14:00:03 -0400
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org,
       auke-jan.h.kok@intel.com
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
Message-ID: <20061017180003.GB24789@tau.solarneutrino.net>
References: <20061013214029.35732.qmail@web83103.mail.mud.yahoo.com> <20061013214250.GC19608@tau.solarneutrino.net> <20061013214523.GK3039@mail.muni.cz> <20061013214608.GD19608@tau.solarneutrino.net> <20061013214922.GL3039@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061013214922.GL3039@mail.muni.cz>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 11:49:22PM +0200, Lukas Hejtmanek wrote:
> On Fri, Oct 13, 2006 at 05:46:08PM -0400, Ryan Richter wrote:
> > > > >   The similar issue has been discussed in adjacent thread "Machine
> > > > >   reboot". Is it Intel motherboard, or just carries Intel chipset ?
> > > > >   Does building e1000 driver as a module and 'rmmod e1000' just before
> > > > >   reboot help ?
> > > > 
> > > > It's an Intel DG965RY board.  I'll try out your suggestion on Monday.
> > > 
> > > Btw, are you using i386 or x86_64 architecture?
> > 
> > x86_64.
> 
> Hm, I'm also using x86_64 and 2.6.19-rc1-git9 works OK for me regardless of
> e1000. 2.6.18 hangs if e1000 is built in.
> 
> Could you also try exactly 2.6.19-rc1-git9?

2.6.19-rc1-git9 doesn't work any better for me.  I haven't tried
unloading the e1000 module yet.  Since I run the machine off an nfsroot,
it will require some creativity to test that.

-ryan
