Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262327AbSKCTQL>; Sun, 3 Nov 2002 14:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSKCTQL>; Sun, 3 Nov 2002 14:16:11 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:32601 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262327AbSKCTQL>; Sun, 3 Nov 2002 14:16:11 -0500
Date: Sun, 3 Nov 2002 14:22:23 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: "David S. Miller" <davem@redhat.com>, Matthew Wilcox <willy@debian.org>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: invalid character 45 in exportstr for include-config
Message-ID: <20021103142223.A10629@devserv.devel.redhat.com>
References: <1036304411.17126.1.camel@rth.ninka.net> <Pine.LNX.4.44.0211031314290.17026-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211031314290.17026-100000@chaos.physics.uiowa.edu>; from kai-germaschewski@uiowa.edu on Sun, Nov 03, 2002 at 01:17:22PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 3 Nov 2002 13:17:22 -0600 (CST)
> From: Kai Germaschewski <kai-germaschewski@uiowa.edu>

> > > Anyone else seeing this error message?  I figured out what it _actually_
> > > means is that the character `-' is not permitted in the symbol being
> > > exported.  so if we change include-config to include_config in Makefile
> > > and scripts/Makefile.build, everything is fine.

> Makes me wonder if Pete's exporting of 'INIT-Y' is a good idea, you may 
> want to change that to '_' as well.

Sorry about that. It's already submitted, so I'll wait until
it recycles through Dave's tree then change it. Thanks for letting
me know, Kai.

-- Pete
