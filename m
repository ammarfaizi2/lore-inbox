Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285110AbRL0Axv>; Wed, 26 Dec 2001 19:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285099AbRL0Axb>; Wed, 26 Dec 2001 19:53:31 -0500
Received: from msp-150.man.olsztyn.pl ([213.184.31.150]:23682 "EHLO
	msp-150.man.olsztyn.pl") by vger.kernel.org with ESMTP
	id <S285110AbRL0Ax3>; Wed, 26 Dec 2001 19:53:29 -0500
Date: Thu, 27 Dec 2001 01:52:36 +0100
From: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011227005236.GB17344@msp-150.man.olsztyn.pl>
In-Reply-To: <20011226233413.GA17037@msp-150.man.olsztyn.pl> <Pine.LNX.4.21.0112262355110.3044-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0112262355110.3044-100000@Consulate.UFP.CX>
User-Agent: Mutt/1.3.24i
X-Linux-Registered-User: 134951
X-Homepage: http://home.elka.pw.edu.pl/~dmierzej/
X-PGP-Key-Fingerprint: B546 B96A 4258 02EF 5CAB  E867 3CDA 420F 7802 6AFE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 27 December 2001, Riley Williams wrote:
> Hi Dominik.
[snip] 
> > I second this. Being a translator of the file in question, I have to
> > deal with ten slightly different versions of "You may also compile
> > this as a module...". So I have ten slighlty different translations
> > of this text, too, in the name of accuracy.
> 
> I have to admit that I hadn't considered translators, but perhaps it
> could be made even simpler for you. How about having the help file start
> with a set of standard definitions, such as the following...
> 
> ===8<=== CUT ===>8===
[cut indeed :-)]
> ===8<=== CUT ===>8===
> 
> The rules would then reduce to "If the relevant condition applies,
> append the text associated with the relevant DEFINE_ symbol to the help
> text to be issued" and this could be done with an additional call to the
> routine to extract the appropriate help text from the file. In addition,
> your translation efforts would be restricted to just the COnfigure.help
> file, and you wouldn't have to tweak the various configuration scripts
> at the same time - and this would also ensure that the various config
> scripts all used exactly the same help text.

Nice, but - as Eric pointed out - there are many options where the
"available as module" text actually contains a module name, which
causes problems and makes your proposition insufficient for our needs.
A complete solution would require serious changes which Eric doesn't
want to introduce into a stable version.
 
> > Although I thought there was an agreement that decimal kilobyte is
> > kB, and binary kilobyte is KiB, decimal megabyte is MB, binary
> > megabyte is MiB and so on, wasn't there?
> 
> That's the standard that the IEC has defined, and what this thread is
> all about. Whether it'll get anywhere remains to be seen - ask Ted T'so
> about the dangers of early adoption of proposed standards, and he'll
> probably explain where his surname came from...

Perhaps I will. But I still don't understand why you insist on choosing
an opposite notation - that is xiB for decimal and xB for binary.
If at all, I would change the traditional convention to something
exactly opposite, i.e. xiB for binary and xB for decimal, because
M(mega),G(giga), etc. are standard SI units.

PS. Don't Cc: me next time you reply, ok? I'm subscribed to lkml.

-- 
"The Universe doesn't give you any points for doing things that are easy."
        -- Sheridan to Garibaldi in Babylon 5:"The Geometry of Shadows"
Dominik 'Rathann' Mierzejewski <rathann(at)we.are.one.pl>
