Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVL1DjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVL1DjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 22:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVL1DjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 22:39:22 -0500
Received: from xenotime.net ([66.160.160.81]:62153 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932460AbVL1DjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 22:39:21 -0500
Date: Tue, 27 Dec 2005 19:39:56 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: michael@metaparadigm.com, pwil3058@bigpond.net.au, rlrevell@joe-job.com,
       s0348365@sms.ed.ac.uk, rostedt@goodmis.org, jaco@kroon.co.za,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume
 support (try 2)
Message-Id: <20051227193956.6fb9e957.rdunlap@xenotime.net>
In-Reply-To: <20051227193309.756f654a.rdunlap@xenotime.net>
References: <43AF7724.8090302@kroon.co.za>
	<200512261535.09307.s0348365@sms.ed.ac.uk>
	<1135619641.8293.50.camel@mindpipe>
	<200512262003.38552.s0348365@sms.ed.ac.uk>
	<1135630831.8293.89.camel@mindpipe>
	<43B1D6C6.30300@metaparadigm.com>
	<43B1E5C1.4050908@bigpond.net.au>
	<43B1F203.6010401@metaparadigm.com>
	<20051227181239.3338b848.rdunlap@xenotime.net>
	<43B204F1.1010409@bigpond.net.au>
	<43B20657.30508@metaparadigm.com>
	<20051227193309.756f654a.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005 19:33:09 -0800 Randy.Dunlap wrote:

[snip]

> > >>>>>>>>>> I use pine and evolution.  Pine is text based and great when I
> > >>>>>>>>>> ssh into
> > >>>>>>>>>> my machine to work.  Evolution is slow, but plays well with pine
> > >>>>>>>>>> and it
> > >>>>>>>>>> handles things needed for LKML very well. (the drop down menu
> > >>>>>>>>>> "Normal"
> > >>>>>>>>>> may be changed to "Preformat", which allows of inserting text
> > >>>>>>>>>> files
> > >>>>>>>>>> "as-is").
> > >>>>>>>>>>       
> > >>>>> This is also the way to do it with Thunderbird. It will do the right
> > >>>>> thing (and disables all formatting changes such as line wrapping
> > >>>>> to the
> > >>>>> inserted text) if you select 'Preformat' before pasting in a patch
> > >>>>> - at
> > >>>>> least my Thunderbird 1.0.7 does this.
> > >>>>>
> > >>>>>>>>> Dare I say it, KMail has also been doing the Right Thing for a
> > >>>>>>>>> long time.
> > >>>>>>>>> It will only line wrap things that you insert by typing; pastes
> > >>>>>>>>> are left
> > >>>>>>>>> untouched.
> > >>>>>>>>>     
> > >>>>>>>>
> > >>>>>>>> It seems that of all the popular mail clients only Thunderbird has
> > >>>>>>>> this
> > >>>>>>>> problem.  AFAICT it's impossible to make it DTRT with inline
> > >>>>>>>> patches and
> > >>>>>>>> even if it is the fact that most users get it wrong points to a
> > >>>>>>>> serious
> > >>>>>>>> usability/UI issue.
> > >>>>>>>>
> > >>>>>>>> Would a patch to add "Don't use Thunderbird/Mozilla Mail" to
> > >>>>>>>> SubmittingPatches be accepted?  Then we can point the Mozilla
> > >>>>>>>> developers
> > >>>>>>>> at it (they have shown zero interest in fixing the problem so far)
> > >>>>>>>> and
> > >>>>>>>> hopefully this will light a fire under someone.
> > >>>>>>>>   
> > >>>>>>>
> > >>>>>>> Fundamentally the issue with Thunderbird is that it line-wraps
> > >>>>>>> AFTER you compose an email, not during composition. I've never
> > >>>>>>> understood how, or why this is useful to the end user, except for
> > >>>>>>> composing HTML emails (which should be banned anyway).
> > >>>>>>>
> > >>>>>>
> > >>>>> Thunderbird will not linewrap anything that is inserted in
> > >>>>> 'Preformat' mode.
> > >>>>>
> > >>>>>
> > >>>>>>> Thunderbird is Yet Another mailer that could have been a good piece
> > >>>>>>> of software if it hadn't attempted to be a clone of Outlook Express
> > >>>>>>> (defaulting to Top Posting, HTML composition, line wrapping
> > >>>>>>> pastes).
> > >>>>>>>
> > >>>>>>> It's the mindset; fixing Thunderbird is probably easy, but
> > >>>>>>> convincing the Mozilla developers to include such "fixes" is
> > >>>>>>> probably much harder.
> > >>>>>>>
> > >>>>>>
> > >>>>>> Should be trivial to fix, when the user puts the editor into
> > >>>>>> "Preformat"
> > >>>>>> mode or inserts a text file you surround it with <pre> tags.
> > >>>>>>
> > >>>>>>
> > >>>>>
> > >>>>> Fix the user behaviour you mean? Get them to select 'Preformat'
> > >>>>> before
> > >>>>> pasting patches into Thunderbird.
> > >>>>
> > >>>>
> > >>>> In my thunderbird, the "Paste Without Formatting" mode seems to be
> > >>>> continually grayed out (i.e. unavailable).  I couldn't find anything
> > >>>> in the preferences that altered this situation.  What's the secret?
> > >>>>
> > >>>
> > >>> I'm selecting 'Preformat' in the email compose window and using regular
> > >>> X Paste (middle button) - and it works for me (I can save the resulting
> > >>> message to a .eml and diff it against the patch and it is perfect).
> > >>> Perhaps the Debian/Sid Thunderbird has some patch? Don't know.
> > >>
> > >>
> > >> so where is this 'Preformat' option?  I don't see it.
> > >
> > >
> > > Nor me.
> > >
> > It is a drop down box in the Compose window just below the subject field
> > on the left (intially says "Body Text").
> 
> However, if one has disabled "Compose messages in HTML format",
> that drop-down list does not show up.
> So does this generate an HTML email, using <preformat> or <tt> etc.?
> If so, still bad.  I'll test it to myself.

Looks good.  Preserves tabs and spaces.  Not HTML email.
Thanks.

> > If you haven't got the rich text Compose enabled (not sure how you
> > disable/enable this but it was an option in Mozilla Mail) you can hold
> > down shift when you click 'Write'.
> > 
> > I'm running Debian/Sid Thunderbird 1.0.7 BTW.


---
~Randy
