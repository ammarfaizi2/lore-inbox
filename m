Return-Path: <linux-kernel-owner+w=401wt.eu-S1030283AbXAKLJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbXAKLJF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 06:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbXAKLJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 06:09:05 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:43123 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030283AbXAKLJD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 06:09:03 -0500
From: CIJOML <cijoml@volny.cz>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.20-rc4: known unfixed regressions (v3)
Date: Thu, 11 Jan 2007 12:08:41 +0100
User-Agent: KMail/1.9.5
Cc: Jiri Kosina <jikos@jikos.cz>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John McCutchan <john@johnmccutchan.com>, rml@novell.com
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <Pine.LNX.4.64.0701111119180.16747@twin.jikos.cz> <20070111105402.GA20027@stusta.de>
In-Reply-To: <20070111105402.GA20027@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701111208.43173.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I all,

I can't work on this until 23.2.2007 because of  my diploma thesis.
But my opinion is - if you make a release with this bug, you'll see more 
reporters soon. It can be than fixed in 2.6.20.1 - I haven't find any data 
corruptions yet.

Michal


Dne ètvrtek 11 leden 2007 11:54 Adrian Bunk napsal(a):
> On Thu, Jan 11, 2007 at 11:21:23AM +0100, Jiri Kosina wrote:
> > On Thu, 11 Jan 2007, Adrian Bunk wrote:
> > > > >Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
> > > > >References : http://bugzilla.kernel.org/show_bug.cgi?id=7785
> > > > >Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
> > > > >Handled-By : John McCutchan <john@johnmccutchan.com>
> > > > >Status     : problem is being debugged
> > > >
> > > > I'm not sure that this is actually a regression for 2.6.20-rc.
> > >
> > > The submitter says it doesn't occur in 2.6.19.
> >
> > Any chance that the submitter could do git bisect? (added to CC). From
> > the bugzilla entry it seems to be well reproducible for him.
>
> That's a possible but time intensive approach for this kind of bug.
>
> I'd expect bisecting such an "at least 1 times a day" bug to take at
> about one month.
>
> And that's not a high number, that's a realistic estimate considering
> that you have to test a dozen kernels and verifying that a kernel is
> good takes 2-3 days.
>
> > Jiri Kosina
>
> cu
> Adrian
