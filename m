Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280854AbRKBWMA>; Fri, 2 Nov 2001 17:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280855AbRKBWLu>; Fri, 2 Nov 2001 17:11:50 -0500
Received: from rly-ip02.mx.aol.com ([152.163.225.160]:38648 "EHLO
	rly-ip02.mx.aol.com") by vger.kernel.org with ESMTP
	id <S280854AbRKBWLd>; Fri, 2 Nov 2001 17:11:33 -0500
Message-ID: <3BE31A2B.9A52ABC4@cs.com>
Date: Fri, 02 Nov 2001 15:11:55 -0700
From: Charles Marslett <cmarslett9@cs.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,zh-TW,ja
MIME-Version: 1.0
To: Greg Sheard <greg@ecsc.co.uk>
CC: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Intel chipset development documents
In-Reply-To: <1004721050.20610.7.camel@lemsip> 
		<20011102183829.A31651@atrey.karlin.mff.cuni.cz> <1004735023.21120.12.camel@lemsip>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Apparently-From: Cmarslett9@cs.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg Sheard wrote:
> 
> On Fri, 2001-11-02 at 17:38, Martin Mares wrote:
> > Hello!
> >
> > > Hi all. Apologies for OT, but this seems the best place to ask.
> > > Intel have removed documentation for the 430VX (Triton) chipset from
> > > their developer site. I'm trying to check that the access details for
> > > the Southbridge are the same as for the 440BX chipset, since I'm working
> > > on some code for direct PCI access. If they're not, could somebody
> > > please let me have the relevant documentation?
> >
> > I guess I could have some 430VX documentation at home (will check
> > tomorrow).
> >
> > As far as I remember, Configuration Type 1 should be supported since
> > the earliest Intel chipset, Type 2 could vary.
> >
> 
> Thanks for that Martin, much appreciated.
> 
> I already have the configuration type down (it's 1), but the 430VX and
> also the VIA 585 seem only to report host bridges. I'm unable to spot
> the piece of code which does different PCI-related things for these
> chipsets in the kernel. Does anybody know if a workaround is applied?
> 
> Regards,
> Greg.

Martin has it backwards, I think.  The 486 chip sets and (maybe) some
of the early Pentium chip sets from Intel are the ones that used Type 2.

All the PPro and newer chip sets use Type 1 so far as I am aware.  Also,
I don't know of any chips that support both -- you get one or the other.

So Type 1 does sound right for the 430VX.

--Charles
