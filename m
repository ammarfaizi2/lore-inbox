Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310943AbSCHQfo>; Fri, 8 Mar 2002 11:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310942AbSCHQfe>; Fri, 8 Mar 2002 11:35:34 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:29700
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310941AbSCHQfV>; Fri, 8 Mar 2002 11:35:21 -0500
Date: Fri, 8 Mar 2002 08:34:48 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Luigi Genoni <kernel@Expansa.sns.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.6 IDE oops with i810 chipset
In-Reply-To: <3C88E412.5080904@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10203080831480.504-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Martin Dalecki wrote:

> Luigi Genoni wrote:
> > Due to a lack of time i tried just 2.5.5, which worked very well.
> > I get the oops while initializing the IDE controller, just after
> > 
> > hdc: LTN485, ATAPI CD/DVD-ROM drive
> > 
> > and before the expected:
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > 
> 
> OK thank you very much this helps. I will actually have to fake the
> detection on my system to think it's the same as yours...
> One thing for sure: it's not dircetly inside the
> PCI host initialization, so I wonder why this problem
> doesn't occur to more people.

You will soon learn about the way ATAPI removable media violate the rules
of how the maintain their status and signal lines.  However you already
knew this information as I am wasting electrons

Andre Hedrick
The Second Linux X-IDE guy

