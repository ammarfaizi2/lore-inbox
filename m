Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285089AbRL0Aka>; Wed, 26 Dec 2001 19:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285096AbRL0AkW>; Wed, 26 Dec 2001 19:40:22 -0500
Received: from msp-150.man.olsztyn.pl ([213.184.31.150]:22402 "EHLO
	msp-150.man.olsztyn.pl") by vger.kernel.org with ESMTP
	id <S285089AbRL0AkL>; Wed, 26 Dec 2001 19:40:11 -0500
Date: Thu, 27 Dec 2001 01:39:17 +0100
From: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Riley Williams <rhw@memalpha.cx>
Subject: Re: Configure.help editorial policy
Message-ID: <20011227003917.GA17344@msp-150.man.olsztyn.pl>
In-Reply-To: <20011223174608.A25335@thyrsus.com> <Pine.LNX.4.21.0112261718150.32161-100000@Consulate.UFP.CX> <20011226190918.B6167@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011226190918.B6167@thyrsus.com>
User-Agent: Mutt/1.3.24i
X-Linux-Registered-User: 134951
X-Homepage: http://home.elka.pw.edu.pl/~dmierzej/
X-PGP-Key-Fingerprint: B546 B96A 4258 02EF 5CAB  E867 3CDA 420F 7802 6AFE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 27 December 2001, Eric S. Raymond wrote:
> Riley Williams <rhw@memalpha.cx>:
> > Alternatively, deal with this problem the same way the "This may also be
> > built as a module..." comment is - either include it several thousand
> > times in Configure.help or (better still) have the configuration tools
> > spit it out automatically every time the need for it crops up. The
> > following ruleset could easily be implemented even in the `make config`
> > and `make menuconfig` parsers, and should be just as easy in CML2.
> > Applying rule (1) will result in a considerable reduction in the size of
> > the file Documentation/Configure.help as it currently stands.
> 
> I have said before; I am *not* going to make KB vs. KiB a
> metaconfiguration option -- that would defeat the whole purpose of
> having standard terminology.  That decision is final, and this subject
> is closed.

With all due respect, Eric, I think you misunderstood. The way I understand
it, Riley is simply proposing to automatically _attach_ an explanation
of the KB/KiB confusion to help text of every option that uses these units.

> The other is not a bad idea in principle.  I've thought before about
> adding a feature that would add specified boilerplate to the help a
> tristate symbol, for exactly the reasons you suggest.  Three things make
> it a bit messy in practice.
> 
> One is that it would have to be expressed in the rulebase, ruther than
> wired into the code.  I will not hardwire specific knowledge about
> the Linux-specific properties of tristate symbols into the CML2 engine.
> CML2 is already being used by at least two projects other than the kernel
> and I know of a third that has it under consideration.  Therefore I must
> preserve its generality.

Fair enough. I don't think anyone would want you to make it Linux-specific.

> The second problem is that the module boilerplate is not all
> boilerplate.  Most instances contain the name of the generated module
> object file.  Thus, ypo do this right, I would have to declare module
> names in the rulebase, one for each tristate entry.  This implies a
> significant extension to the CML2 language, which I'm reluctant to do
> right now.  The design is stable.  I want it to stay that way until
> (at least) well after CML2 achieves acceptance.
> 
> Third, I don't want to do major surgery on Configure.help until after
> CML2 enters the tree.  Were I to do so, I would then have to maintain
> two different versions of Configure.help.  That would be too big a pain.
> 
> Therefore, I'm going to defer consideration of this feature for now.
> I certainly will not consider it until after CML2 goes into the 2.5 tree,
> and may not consider it until there is some kind of final decision on
> a 2.4 backport.

Again, these are all valid points. I guess you could just put this idea
far on the TODO list for now. :-)
Same thing applies to the first part of Riley's proposition, it would seem.

-- 
"The Universe doesn't give you any points for doing things that are easy."
        -- Sheridan to Garibaldi in Babylon 5:"The Geometry of Shadows"
Dominik 'Rathann' Mierzejewski <rathann(at)we.are.one.pl>
