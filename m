Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276126AbRJBS1K>; Tue, 2 Oct 2001 14:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276118AbRJBS1A>; Tue, 2 Oct 2001 14:27:00 -0400
Received: from web13104.mail.yahoo.com ([216.136.174.149]:43014 "HELO
	web13104.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276125AbRJBS0r>; Tue, 2 Oct 2001 14:26:47 -0400
Message-ID: <20011002182715.25244.qmail@web13104.mail.yahoo.com>
Date: Tue, 2 Oct 2001 11:27:15 -0700 (PDT)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Which is currently the most stable 2.4 kernel?
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
In-Reply-To: <306940000.1002046587@tiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The UP server does the PPPoE, so that's OK. Has anyone
torture-tested any of the recent kernels? For
instance, I subsequently read a posting from Alan Cox
saying that 2.4.10 didn't survive overnight for him,
implying that he occasionally roasts penguins in some
kind of server-dungeon...

Cheers,
Chris

--- Chris Mason <mason@suse.com> wrote:
> 
> 
> On Tuesday, October 02, 2001 11:05:02 AM -0700 Chris
> Rankin
> <rankincj@yahoo.com> wrote:
> 
> > All that the servers would be doing would be
> > connecting to the Internet periodically using
> PPPoE
> > and DSL (with NAT), forwarding emails and
> performing
> > various CPU-bound tasks. They should both have
> ample
> > available memory and should not need to swap much,
> if
> > at all.
> > 
> > Does anyone have any kernel recommendations /
> > counter-recommendations, please? One server is
> SMP,
> > the other is UP, and both are Intel architecture.
> 
> PPP is not SMP safe in 2.4.x.  You'll run into
> problems on any kernel
> there.  Even on single processor systems, you need
> the ppp patch in
> 2.4.9-ac16 or 2.4.11pre1.
> 
> Other than that, 2.4.10 + andrea's vmtweaks patch
> does well.  2.4.9-ac18 is
> a good alternative.
> 
> -chris
> 


__________________________________________________
Do You Yahoo!?
Listen to your Yahoo! Mail messages from any phone.
http://phone.yahoo.com
