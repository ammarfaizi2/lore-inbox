Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTLIJTx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266160AbTLIJTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:19:52 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:24214 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263787AbTLIJTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:19:49 -0500
To: Greg KH <greg@kroah.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Witukind <witukind@nsbm.kicks-ass.org>, recbo@nishanet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
References: <200312081536.26022.andrew@walrond.org>
	<20031208154256.GV19856@holomorphy.com>
	<3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com>
	<20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
	<20031209075619.GA1698@kroah.com> <1070960433.869.77.camel@nomade>
	<20031209090815.GA2681@kroah.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 09 Dec 2003 18:19:37 +0900
In-Reply-To: <20031209090815.GA2681@kroah.com>
Message-ID: <buoiskqfivq.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
> > >   A:  That is correct.  If you really require this functionality, then
> > >       use devfs.  There is no way that udev can support this, and it
> > >       never will.
> > 
> > That's something I don't understand: I thought that with a well
> > configured hotplug+udev system, you'll never have to worry about loading
> > drivers on device-node open() because all drivers should be auto-loaded
> > and all device-nodes should be auto-created.
> 
> No, you are correct.  That's why I'm not really worried about this, and
> I don't think anyone else should be either.

Is there a specific case for which people want this feature?
Offhand it seems like a slightly odd thing to ask for...

-Miles
-- 
P.S.  All information contained in the above letter is false,
      for reasons of military security.
