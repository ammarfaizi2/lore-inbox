Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbUKQSHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbUKQSHq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbUKQSGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:06:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:39901 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262436AbUKQR7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:59:19 -0500
Date: Wed, 17 Nov 2004 09:59:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: GPL version, "at your option"?
In-Reply-To: <1100708189.512.64.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0411170936540.2222@ppc970.osdl.org>
References: <1100614115.16127.16.camel@ghanima> 
 <Pine.LNX.4.53.0411161547260.7946@gockel.physik3.uni-rostock.de> 
 <Pine.LNX.4.58.0411160746030.2222@ppc970.osdl.org> 
 <1100704183.32677.28.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0411170822200.2222@ppc970.osdl.org>
 <1100708189.512.64.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Nov 2004, Alan Cox wrote:
> 
> Well no obligation exists, but please add "All code owned by Alan Cox
> and present in this kernel is licensed GPL v2 or later" to your copying
> or another appropriate file. (A comment in the code for each one would
> be rather messy)

It really doesn't help with a single person, since any code you wrote you 
can do anything with _anyway_ (ie you're not even bound by the GPL at all, 
since you can re-license it under whatever license you want). So naming 
people really doesn't help anybody, while naming _files_ does (because 
then _others_ than you can decide to relicense based on that file).

See what I'm saying? You as the author always have full rights, which is 
why the "v2 or later" really needs to be attached to _code_, not to a 
person. You may know the code you wrote, but very few other people will. 

Also, attaching it to the code is the only way to have places with 
multiple developers (and let's face it, these days that's pretty much 
every corner of the kernel) to note the "compunded" rules. 

> It might be a good idea to figure out how to have a list of contributors
> who've said that or "v2 - or if Linus Torvalds so chooses, a later
> version"

Yes, modulo again the fact that I really don't think it's about people but
about files. Not just because of the argument above, either: some people
might really do licensing per file: I've done it myself (ie I allowed my
original stupid math emulator to be relicenced under the BSD license, even
though I would not do that for other things). Also, I'd be willing to do 
the "v2 or later" on my code if somebody else has been working on it a lot 
and feels strongly about it, even though I do not in _general_ tend to 
agree with a carte blanche for the FSF to make up any random license.

For all we know, GPL v3 will really be a good license, and everybody will
agree that we want to upgrade. I just don't _know_, and I'm not willing to 
just take something that important on trust.

> > Note the "IF". Linux _never_ had the "v2 or later" clause, so that "if" 
> > was never an issue, and the clarification on top of the COPYING file 
> > really _is_ just a clarification.
> 
> Correction noted. I went and checked 1.2.0 and indeed it says nothing
> about versions in that specific top level file.

Indeed. There are a lot of files that _do_ have the boilerplate thing, but
those obviously aren't in question (although iirc last time when this
detail came up and I pointed out what the real rules wrt that "v2 or
later" were, some people actually _removed_ their thing too, so the
confusion about these things and the preferences can obviously go either
way).

		Linus
