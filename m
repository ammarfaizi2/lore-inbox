Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262203AbREQWmY>; Thu, 17 May 2001 18:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262200AbREQWmO>; Thu, 17 May 2001 18:42:14 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:4872 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262201AbREQWl6>; Thu, 17 May 2001 18:41:58 -0400
Date: 17 May 2001 23:06:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <811oowp1w-B@khms.westfalen.de>
In-Reply-To: <200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca>
Subject: Re: LANANA: To Pending Device Number Registrants
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3B02DD79.7B840A5B@transmeta.com> <3B02D6AB.E381D317@transmeta.com> <200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca> <3B02DD79.7B840A5B@transmeta.com> <200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rgooch@ras.ucalgary.ca (Richard Gooch)  wrote on 16.05.01 in <200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca>:

> H. Peter Anvin writes:
> > Richard Gooch wrote:
> > >
> > > H. Peter Anvin writes:
> > > > Richard Gooch wrote:
> > > > > Argh! What I wrote in text is what I meant to say. The code didn't
> > > > > match. No wonder people seemed to be missing the point. So the line
> > > > > of code I actually meant was:
> > > > >         if (strcmp (buffer + len - 3, "/cd") != 0) {
> > > >
> > > > This is still a really bad idea.  You don't want to tie this kind of
> > > > things to the name.
> > >
> > > Why do you think it's a bad idea?
> >
> > Because you are now, once again, tying two things that are
> > completely and utterly unrelated: device classification and device
> > name.  It breaks every time someone comes out with a new device
> > which is "kind of like an old device, but not really," like
> > CD-writers (which was kind-of-like WORM, kind-of-like CD-ROM) and
> > DVD (kind-of-like CD)...
>
> But all devices which export a CD-ROM interface will do so. So the
> device node that is associated with the CD-ROM driver will export
> CD-ROM semantics, and the trailing name will be "/cd".

Uh, how do they have the filename end in more than one device type suffix  
at the same time?

That was the point, remember. You're trying to find out about a device on  
the end of your file handle, and that device *does* match more than one of  
these.

MfG Kai
