Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSC1Alg>; Wed, 27 Mar 2002 19:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311180AbSC1Al2>; Wed, 27 Mar 2002 19:41:28 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:16646
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311121AbSC1AlP>; Wed, 27 Mar 2002 19:41:15 -0500
Date: Wed, 27 Mar 2002 16:40:49 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Erik Andersen <andersen@codepoet.org>, Jos Hulzink <josh@stack.nl>,
        jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
In-Reply-To: <20020327193126.J29474@redhat.com>
Message-ID: <Pine.LNX.4.10.10203271632530.6006-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Benjamin LaHaise wrote:

> On Wed, Mar 27, 2002 at 04:23:34PM -0800, Andre Hedrick wrote:
> > There was one company how got it correct, but I do not know if they are
> > still around.  The solution is not CHEAP, it requires total HOST vender
> > unique callers and special state diagrams.  Also this was a true
> > Master/Slave pair solution, the hook was it broke the timing skews on the
> > buss. Thus Ultra33 or mode 2 as the limit.
> 
> What about the hot swap bays I've picked up that properly handle power 
> up/down?  If that is the only device on the bus and the interface is 
> properly tristated, what prevents hot swap?

Power is one issue and another is shock on the buss, there are more.
Get the power wrong (grounding order) and you pull current off the ribbon.
Pull current of the ribbon, you blue-smoke the other device and or the
host.  Fail to invoke a tristate block at the device in a master/slave and
you introduce shock and and data corrution.

Have I made it work in linux in the past safely yes, did it take special
hardware you bet.  Can you get it OTC, no.  Is is still findable not sure.
Is there a proper demand that I could go back to the known chip maker and
board maker to get them to bring it off the shelf, I doubt it.

All the users in Linux (to date) are not a big enough customer base.
If you think it is big enough, look at the shipping numbers.
I did this once back in earlier 2000 and got burned as did two companies.

Regards,

Andre Hedrick
LAD Storage Consulting Group

