Return-Path: <linux-kernel-owner+w=401wt.eu-S932805AbWLNPfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbWLNPfT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932806AbWLNPfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:35:19 -0500
Received: from thunk.org ([69.25.196.29]:60543 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932805AbWLNPfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:35:17 -0500
Date: Thu, 14 Dec 2006 09:53:16 -0500
From: Theodore Tso <tytso@mit.edu>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214145315.GB9079@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
	Martin Bligh <mbligh@mbligh.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <1166084480.5253.849.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166084480.5253.849.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>But I would ask that they honour the licence on the code I release, and
>perhaps more importantly on the code I import from other GPL sources.

It's not a question of "honoring the license"; it's a matter of what
is the reach of the license, as it relates to derivitive works.  It's
a complicated subject, and very dependent on the local law; certainly
in the U.S., when I asked a Law Professor from the MIT Sloan School of
Management, who specialized in IP issues about the FSF theory of GPL
contamination by dynamic linking, after I explained all the details of
how dynamic linking work, she told me that it would be "laughed out of
the courtroom".  

Now, is that a legal opinion?  No, because the facts of every single
case are different, and it was an opinion from someone over a decade
ago, and case law may have changed (although as far as I know, there
has been no court ruling directly on this particular point since
then).

The bottom line though is that it is not _nearly_ so clear as some
people would like to believe.  There is a lot of gray --- and that's a
GOOD thing.  If copyright contamination via dynamic linking was the
settled law of the land, then all of the Macintosh extensions that
people wrote --- WHICH WORK BY PATCHING THE OPERATING SYSTEM --- would
be illegal.  And given how much Apple hated people implying that the
UI as handed down from the mountain by the great prophet Steve Jobs
wasn't good enough, would we really have wanted Apple hounding
developers with lawsuits just because "they weren't honoring the
license" by daring to patch MacOS, and extending the OS by linking in
their code?

And what about people who link in a debugger into the Microsoft HAL or
other Microsoft DLL's in order to reverse engineer USB drivers for
Linux or reverse engineer protocols for Samba --- that's dynamic
linking of a sort too --- should that be illegal as well?  Imagine the
power that Microsoft could put into their EULA if copyright
contamination could be as easily achieved by dynamic linking.

Please, let's try to have a little sanity here,

						- Ted
