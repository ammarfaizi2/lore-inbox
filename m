Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSHUAzy>; Tue, 20 Aug 2002 20:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSHUAzy>; Tue, 20 Aug 2002 20:55:54 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:4314 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S317619AbSHUAzx>; Tue, 20 Aug 2002 20:55:53 -0400
Message-ID: <288F9BF66CD9D5118DF400508B68C4460283E4B3@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Troy Wilson'" <tcw@tempest.prismnet.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
       Martin.Bligh@us.ibm.com, tcw@prismnet.com
Subject: RE: mdelay causes BUG, please use udelay
Date: Tue, 20 Aug 2002 17:59:44 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Jeff, 10000 seems on the border of what's OK.  If it's acceptable, 
> > then let's go for that.  Otherwise, we're going to have to chain 
> > several mod_timer callbacks together to do a controller reset.
> 
> For some telco and embedded apps 10000 in an IRQ is 
> borderline. One day the timer stuff will be needed - how hard 
> is it to fix right first time ?

Ok, ok, 10000 is bad, even when reseting the part, no problem.  It's not to
hard to fix the right way; I'll work on a patch to give to Jeff.

-scott
