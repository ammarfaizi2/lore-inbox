Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVLZT1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVLZT1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVLZT1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:27:21 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:37068 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932112AbVLZT1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:27:20 -0500
Subject: Re: recommended mail clients
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jaco Kroon <jaco@kroon.co.za>, jason@stdbev.com, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz, s0348365@sms.ed.ac.uk
In-Reply-To: <43B041FA.8000404@pobox.com>
References: <43AF7724.8090302@kroon.co.za> <43AFB005.50608@kroon.co.za>
	 <1135607906.5774.23.camel@localhost.localdomain>
	 <200512261535.09307.s0348365@sms.ed.ac.uk>
	 <1135619641.8293.50.camel@mindpipe>
	 <0f197de4ee389204cc946086d1a04b54@stdbev.com>
	 <1135621183.8293.64.camel@mindpipe> <43B03658.9040108@kroon.co.za>
	 <43B041FA.8000404@pobox.com>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 14:32:29 -0500
Message-Id: <1135625550.8293.86.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-26 at 14:18 -0500, Jeff Garzik wrote:
> Jaco Kroon wrote:
> > Lee Revell wrote:
> > 
> >>On Mon, 2005-12-26 at 12:09 -0600, Jason Munro wrote:
> >>
> >>
> >>>On 11:54:00 am 26 Dec 2005 Lee Revell <rlrevell@joe-job.com> wrote:
> >>>
> >>><snip>
> >>>
> >>>>>Dare I say it, KMail has also been doing the Right Thing for a
> >>>>>long time. It will only line wrap things that you insert by
> >>>>>typing; pastes are left untouched.
> >>>>
> >>>>It seems that of all the popular mail clients only Thunderbird has
> >>>>this problem.  AFAICT it's impossible to make it DTRT with inline
> >>>>patches and even if it is the fact that most users get it wrong
> >>>>points to a serious usability/UI issue.
> >>>>
> >>>>Would a patch to add "Don't use Thunderbird/Mozilla Mail" to
> >>>>SubmittingPatches be accepted?  Then we can point the Mozilla
> >>>>developers at it (they have shown zero interest in fixing the problem
> >>>>so far) and hopefully this will light a fire under someone.
> > 
> > 
> > I would second that patch.
> 
> I would NAK such a patch.
> 
> Andrew Morton described a way to do it, some method using x cut buffers, 
> IIRC.
> 
> The best thing to do is use a custom script, though.  Other mailers can 
> be annoying as well, with regards to the References header, for example. 
>   And pine is awful, encoding plain text as base64.

For a maintainer who patch bombs LKML constantly a custom script is best
but for the casual contributor their mailer should just work.

The default Gnome and KDE mail clients work OK so why don't we just try
to get Thunderbird fixed or at least warn about it?  Casual contributors
are very likely to read SubmittingPatches.

I'm not trying to find the one true solution I'd just like to end the
constant low grade noise (and higher bug fix latency!) of "Please
resend, your patch is linewrapped" every few days.

Lee

