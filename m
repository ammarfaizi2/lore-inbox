Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWBMXv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWBMXv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWBMXv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:51:56 -0500
Received: from smtp.enter.net ([216.193.128.24]:62215 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030309AbWBMXvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:51:55 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 19:01:00 -0500
User-Agent: KMail/1.8.1
Cc: davidsen@tmr.com, chris@gnome-de.org, nix@esperi.org.uk,
       linux-kernel@vger.kernel.org, axboe@suse.de
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <1139615496.10395.36.camel@localhost.localdomain> <43F088AB.nailKUSB18RM0@burner>
In-Reply-To: <43F088AB.nailKUSB18RM0@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131901.01158.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 08:24, Joerg Schilling wrote:
> Christian Neumair <chris@gnome-de.org> wrote:
> > Am Freitag, den 10.02.2006, 16:06 -0500 schrieb Bill Davidsen:
> > > The kernel could provide a list of devices by category. It doesn't have
> > > to name them, run scripts, give descriptions, or paint them blue. Just
> > > a list of all block devices, tapes, by major/minor and category (ie.
> > > block, optical, floppy) would give the application layer a chance to do
> > > it's own interpretation.
> >
> > Introducing more than interface for doing the same thing can be very
> > confusing and counter-productive. You'll create new, undocumented or
> > semi-documented interfaces which will lead to a dependency chaos.
>
> So you concur with me that the fact that Linux introduced another interface
> for SCSI was onfusing and counter-productive.

And look - ide-scsi is going away. So that "new" interface is disappearing.

<snip>
> > > Since -scanbus tells you a
> > > device is a CDrecorder, or something else, *any user* is likely to be
> > > able to tell it from DCD, CD-ROM, etc. Nice like of text for most
> > > devices...
> >
> > Well, "any user" just opens his Windows Explorer and takes a look at the
> > icon of his drive D:\\ to see whether it's a CD-ROM or DVD. It is
> > interesting to see professional programmers often argue that a
>
> This is not true: a drive letter mapping does not need to exist on MS-WIN
> in order to be able to access it via ASPI or SPTI.

And only true in those cases, although I have seen (thanks to necessity, not 
choice) that NT (and therefore Win32) does do btl mappings internally at 
least at boot. But if you claim that SPTI or ASPI is necessary to burn CD's 
on windows you are sadly mistaken. There are a number of programs which 
_might_ do ASPI internally, but never export the interface, so how does 
Windows use it? And with XP, again, thanks to necessity (making money in both 
cases) I can easily state that Windows does burning _internally_ without 
ASPI. (which I know doesn't exist because of complaints form WinAmp about the 
same)

DRH
