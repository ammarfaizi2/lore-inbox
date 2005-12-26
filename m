Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVLZSOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVLZSOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVLZSOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:14:42 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:15490 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932079AbVLZSOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:14:41 -0500
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume
	support (try 2)
From: Lee Revell <rlrevell@joe-job.com>
To: jason@stdbev.com
Cc: rostedt@goodmis.org, jaco@kroon.co.za, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, s0348365@sms.ed.ac.uk
In-Reply-To: <0f197de4ee389204cc946086d1a04b54@stdbev.com>
References: <43AF7724.8090302@kroon.co.za> <43AFB005.50608@kroon.co.za>
	 <1135607906.5774.23.camel@localhost.localdomain>
	 <200512261535.09307.s0348365@sms.ed.ac.uk>
	 <1135619641.8293.50.camel@mindpipe>
	 <0f197de4ee389204cc946086d1a04b54@stdbev.com>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 13:19:43 -0500
Message-Id: <1135621183.8293.64.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-26 at 12:09 -0600, Jason Munro wrote:
> On 11:54:00 am 26 Dec 2005 Lee Revell <rlrevell@joe-job.com> wrote:
> 
> <snip>
> 
> > >  Dare I say it, KMail has also been doing the Right Thing for a
> > >  long time. It will only line wrap things that you insert by
> > >  typing; pastes are left untouched.
> >
> > It seems that of all the popular mail clients only Thunderbird has
> > this problem.  AFAICT it's impossible to make it DTRT with inline
> > patches and even if it is the fact that most users get it wrong
> > points to a serious usability/UI issue.
> >
> > Would a patch to add "Don't use Thunderbird/Mozilla Mail" to
> > SubmittingPatches be accepted?  Then we can point the Mozilla
> > developers at it (they have shown zero interest in fixing the problem
> > so far) and hopefully this will light a fire under someone.
> 
> Maybe this is a stupid question but in terms of inline patches what exactly
> would be ideal behavior from a mail client for LKML patch submitters? What
> line lengths are expected to be maintained, preferred encodings, tabs vs.
> spaces, etc? I have noticed that some patch submitters append an EOF after
> the patch, while others do not. Would the ability to pull the patch from
> the message body (assuming there was an agreed upon patch termination
> string) as a separate file/download be useful? Though my client is web
> based it is quite speedy and can handle large folders as well as many
> desktop clients IMHO. I would gladly implement specific features to make
> patch submission for LKML compliant.

The specifics do not matter.  It does not even have to do what we want
by default when you paste or insert text.  There just has to be SOME way
(well, some reasonable way - a global config option is not reasonable)
to insert a text file and paste from the clipboard as-is, no tab->space
conversion, no line wrapping, nothing.

Lee

