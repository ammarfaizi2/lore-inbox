Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWAUB4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWAUB4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWAUB4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:56:38 -0500
Received: from web81908.mail.mud.yahoo.com ([68.142.207.187]:18084 "HELO
	web81908.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932384AbWAUB4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:56:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6pwl+LjY7DilWSazHZv0Pa8wzvlrsap14Nb1I/ITFTzRIh1sAoG0I47U3CIb66BaTJTcOkDbDEfT5YK8tXuAwLNLXNfHdhHjjvcNpyEUMFfZIsy5U4PRRLtMzU+2Iwan2GAJizKA9tL+PBHhpcf1MKR+gvJF9eSMhPGmUHDfxaA=  ;
Message-ID: <20060121015634.32246.qmail@web81908.mail.mud.yahoo.com>
Date: Fri, 20 Jan 2006 17:56:34 -0800 (PST)
From: Matthew Frost <artusemrys@sbcglobal.net>
Subject: Re: Development tree, PLEASE?
To: Michael Loftis <mloftis@wgops.com>
Cc: linux-kernel@vger.kernel.org, James Courtier-Dutton <James@superbug.co.uk>
In-Reply-To: <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Michael Loftis <mloftis@wgops.com> wrote:

> 
> 
> --On January 20, 2006 4:29:44 PM +0000 James Courtier-Dutton 
> <James@superbug.co.uk> wrote:
> 
> > It is unclear what you are really ranting about here. The "stable"
> > kernel is stable or at least as stable as it is going to be. It is
> > left to distros to make it even more stable. The interface to user
> > land has not changed.
> > If all you are ranting about is the move from devfs to udevd, 
> > then all the user land tools dealing with them have been updated
> > already.
> 

Amen.  devfs has sat in the kernel for an entire major release, 2.4, and
gotten dustier and dustier.  It was deprecated when gregkh asked to
remove it *1 YEAR* before the community let him.  1 whole year prior to
the "last chance" email.  You cannot state that it is anyone's fault but
your own that you missed that.  Your complaint, as far as any of us can
dredge a legitimate complaint out of the noise, is a devfs complaint.  If
you wish to protest the removal of an unused, unmaintained, and
long-deprecated subsystem, title your message such that we understand
that you are complaining about that subsystem.  DO NOT protest about the
stability of the kernel series.  That is not your legitimate issue.  If
you have stability problems, find the cause of the system instability and
email the list about it, to get it fixed.  If you have a complaint about
a new commit in a current series, say 2.6.15, or a patch thereunto
appertaining, note the patch, and discuss why it is problematic.

But if all you're whinging about is devfs being out of 2.6 midstream when
 nobody's using it and there are options for those who do, tell us so. 
Then, we can tell you to used udevd or ndevfs and get out of our hair.

> That's the nail on the head exactly.  Why is this being done in an even
> numbered kernel?  This represents an API change that has knock on well 
> outside of the kernel, and should be done in development releases.  Why
> is it LK is the only major project (that I know of) that does this? 
This
> is akin to apache changing the format of httpd.conf and saying in say
> 1.3.38 and saying 'well we made the userland tools too.'

The kernel is a law unto itself because the kernel is a project like
precious few others.  Name a project like unto the kernel, with the
degrees of similarity and applicability for the given solution, and the
solution as it should logically apply to the kernel for the kernel's
similarity to that project, and maybe we'll talk.  Apache is nothing
like.  Linus has long said that "X does it this way" is not a reason to
do it that way.

> 
> >
> > What is the real specific problem you are having?

(Please, do tell, if it's not devfs)

> 
> Well there's a whole grab bag of them that I'll be getting to over the
> next few months, but the most immediate is the fact that I've gotten
new 
> hardware from a venduh that requires me to build a new Debian installer
> and new debian kernels.  I also have custom packages that depend on
devfs
> being there and now it's not.
> 

No.  Wrong.  If there're a whole grab bag, as you say, then you should
post each, as a separate issue, possibly with consistent proposals for
fixing them.  Follow protocol.  Posting a "The Kernel Is Falling" email
gets people riled up, makes you look foolish, and gets nothing fixed. 
Noise.  Send signal.  We'll wait.

Your "venduh" hardware really is a separate issue, unless you mean to say
that your complaint is that you got too used to devfs and now don't know
how to write drivers.  And it doesn't play nice with Debian?  Why, this
is the kernel mailing list.  I'm sorry, you want
debian-mentors@lists.debian.org or debian-devel@lists.debian.org, if
you're a Debian developer, or debian-kernel@lists.debian.org, if it's a
Debian kernel question (I'm sure they've lots of experience with not
using devfs by now), or possibly debian-user@lists.debian.org.  Your
custom packages should have source with them, or available, because they
should be GPL.  Do a little legwork.


> Yes I realise this change isn't out of the blue or anything, but it's
> in a 'stable' kernel.  Why bother calling 2.6 stable?  We may as well
> have stayed at 2.5 if this sort of thing is going to continue to be
> pulled.
>

What sort of thing?  Removal of long-deprecated subsystems that as much
as scream "Don't use me!  I'm going away!"?  That sort of thing?

How many 2.5 kernels could you actually run a production system on?  2.6
is remarkably version-interoperable for a kernel that a) works, b)
continues to get new code applied to it, c) is not dead, and d) everybody
complains about miserably.  It is remarkably stable in function.  Maybe
when we drop ata support for a bio implementation, we'll get a 2.7
series.  That might be a compatibility breaker.  But changing layers of
abstraction while leaving a perfectly functional migration path for users
of old code?  Dust off your brain and follow the well-blazed trail.

Please try to limit yourself to actual issues with actual kernels, and
title your emails something appropriate and non-incendiary.  And, do try
to keep up with current events.
 
> >
> > James
> >
> >
> 
> 
> 
> --
> "Genius might be described as a supreme capacity for getting its
> possessors
> into trouble of all kinds."
> -- Samuel Butler
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
