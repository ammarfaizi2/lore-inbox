Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261575AbREOVe2>; Tue, 15 May 2001 17:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbREOVeT>; Tue, 15 May 2001 17:34:19 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:39174 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S261575AbREOVeG>;
	Tue, 15 May 2001 17:34:06 -0400
Date: Tue, 15 May 2001 17:33:16 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jes Sorensen <jes@sunsite.dk>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010515173316.A8308@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jes Sorensen <jes@sunsite.dk>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010505192731.A2374@thyrsus.com> <d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com> <d3d79awdz3.fsf@lxplus015.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <d3d79awdz3.fsf@lxplus015.cern.ch>; from jes@sunsite.dk on Tue, May 15, 2001 at 10:32:00PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@sunsite.dk>:
> If Ray wants to fix things, it's just fine with me.

I have corrected the Mac dependencies as Ray directed.
  
> Eric> Does this mean you'll take over maintaining the CML2 rules files
> Eric> for the m68k port, so I don't have to?  That would be wonderful.
> 
> For a start, so far there has been no reason whatsoever to change the
> format of definitions.

The judgment of the kbuild team is unanimous that you are mistaken on this.
That's the five people (excluding me) who wrote and maintained the CML1 code.
*They* said that code had to go, Linus has concurred with their judgment, 
and the argument is over.

> So far you have only been irritating developers for no reason. What I
> asked you to do is to NOT change whatever config options developers
> developers felt were necessary to introduce. If you want to change the
> format of the config.in files go ahead. Messing around with the config
> options themselves is *not* for you to do, nor are you to impose a
> more restrictive space for people to work in.

If you persist in misunderstanding what I am doing, you are neither
going to be able to influence my behavior nor to persuade other people
that it is wrong.  Listen carefully, please:

1. The CML2 system neither changes the CONFIG_ symbol namespace nor 
   assumes any changes in it.  (Earlier versions did, but Greg Banks
   showed me how to avoid needing to.)

2. The ruleset changes I have made simplify the configuration process,
   but they do *not* in any way restrict the space of configurations 
   that are possible.  By design, every valid (consistent) configuration
   in CML1 can be generated in CML2.  I treat departures from that rule
   as rulesfile bugs and fix them (as I just did at Ray Knight's instruction).

3. I do not have (nor do I seek) the power to "impose" anything on anyone.

You really ought to give CML2 a technical evaluation yourself before you
flame me again.  Much of what you seem to think you know is not true.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

According to the National Crime Survey administered by the Bureau of
the Census and the National Institute of Justice, it was found that
only 12 percent of those who use a gun to resist assault are injured,
as are 17 percent of those who use a gun to resist robbery. These
percentages are 27 and 25 percent, respectively, if they passively
comply with the felon's demands. Three times as many were injured if
they used other means of resistance.
        -- G. Kleck, "Policy Lessons from Recent Gun Control Research,"
