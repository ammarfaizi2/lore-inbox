Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbUAWPiP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUAWPiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:38:15 -0500
Received: from redfish.gatech.edu ([130.207.165.230]:54185 "EHLO
	cyberbuzz.gatech.edu") by vger.kernel.org with ESMTP
	id S262767AbUAWPiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:38:12 -0500
Date: Fri, 23 Jan 2004 10:38:11 -0500 (EST)
From: Chris Ricker <kaboom@gatech.edu>
Reply-To: Chris Ricker <kaboom@gatech.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, jw@pegasys.ws,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Confirmation Spam Blocking was: List 'linux-dvb' closed to
 public posts
In-Reply-To: <20040122224902.0f8aff9c.davem@redhat.com>
Message-ID: <Pine.GSO.4.58.0401231034240.26155@redfish.gatech.edu>
References: <Pine.LNX.4.58.0401211155300.2123@home.osdl.org>
 <1074717499.18964.9.camel@localhost.localdomain> <20040121211550.GK9327@redhat.com>
 <20040121213027.GN23765@srv-lnx2600.matchmail.com>
 <pan.2004.01.21.23.40.00.181984@dungeon.inka.de> <1074731162.25704.10.camel@localhost.localdomain>
 <yq0hdyo15gt.fsf@wildopensource.com> <401000C1.9010901@blue-labs.org>
 <Pine.LNX.4.58.0401221034090.4548@dlang.diginsite.com> <40101B1E.3030908@blue-labs.org>
 <20040122221802.GD12666@pegasys.ws> <Pine.LNX.4.58.0401221441500.2998@home.osdl.org>
 <20040122224902.0f8aff9c.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004, David S. Miller wrote:

> On Thu, 22 Jan 2004 14:58:54 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Have you played with Markov chains? What happens is that you don't just
> > build up a list of words and their likelihood of being spam or ham, you
> > build up a list of word _combinations_ and the likelihood of one
> > particular word following another one.
> > 
> > That's how a lot of the "random phrase" generators on the web work.
> > 
> > They can be absolutely hilarious, exactly because the sentences they
> > generate actually _almost_ make sense. Sometimes you get an almost 
> > readable story, but one that reads like somebody having a bad trip and his 
> > reality just shifted 90 degrees. (Usually the best stories come if the 
> > training material is coherent, which email sadly usually isn't).
> 
> This reminds me of the literary work done by William S. Burrough and his
> infamous "cut ups".  Similar result for the reader.

jwz's DadaDodo program <http://www.jwz.org/dadadodo/> was inspired by 
Burroughs' cut ups, and it does this sort of Markov chain-based 
generation....
                                                                                
I'm not so sure that Markov chain analysis for spam filtering will work well
in practice for email, though, particularly when dealing with international
email. I don't write / read German or French well, but I can write in them
enough that a German / French speaker can figure out what I'm trying to say,
maybe. My German in particular is bad enough that it probably wouldn't fit
Markov chain models of how someone fluent in high German would write,
though. Similarly, look at some of the fractured English emails that appear
on this list. I can understand them, but a Markov model relaxed enough to
allow them will also include a lot of random spam....

later,
chris
