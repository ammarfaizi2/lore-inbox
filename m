Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292379AbSBPPQl>; Sat, 16 Feb 2002 10:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292380AbSBPPQc>; Sat, 16 Feb 2002 10:16:32 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:63495
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292379AbSBPPQS>; Sat, 16 Feb 2002 10:16:18 -0500
Date: Sat, 16 Feb 2002 09:50:39 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: That Linux Guy <thatlinuxguy@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216095039.L23546@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	That Linux Guy <thatlinuxguy@hotmail.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com><200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com><20020215141433.B11369@thyrsus.com><20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com><20020215145421.A12540@thyrsus.com><20020215124255.F28735@work.bitmover.com><20020215153953.D12540@thyrsus.com> <1013811711.807.1066.camel@phantasy> <OE193Qime2yO9QJsWhz00006b54@hotmail.com> <3C6DE7DC.59A92A6D@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6DE7DC.59A92A6D@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Feb 16, 2002 at 12:02:20AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com>:
> I consider CML2 an albatross now, and the maintainer does not listen to
> feedback.

New FAQ entry:

* Eric doesn't listen to feedback.

Bill Stearns observed in February 2002 that "Eric has been very good
about folding in changes".  In response to feedback from the kernel
mailing list, Eric has:

- introduced the prefix declaration so that symbol names can be 
  expressed with or without the CONFIG_

- added a recovery mechanism so the configurator can do someting
  with inconsistent configs (this one was Alan Cox's issue).

- removed the magic tie declaration that made symbols without help
  only visible in EXPERT mode

- reorganized the rulebase to minimize stuff in the root rules file

- added the capability to annotate constraint violations with 
  text messages in English or the language of your choice.

- sped up the rulebase compiler by a factor of six

and many other changes comprising months of work.
 
> I would be happy as a clam if Eric wanted to resolve the problems -we-
> have with CML1 and the config system, not just the problems he has with
> it.

What problems do you have with CML1?  Name them and I will make sure
they are not issues in CML2.

I've been begging for feedback for many months.  Pleases *get specific*.
Instead of muttering that Eric refuses to listen, *give me something
to listen to*!
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
