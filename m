Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbTJNNo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 09:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbTJNNo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 09:44:29 -0400
Received: from mail-05.iinet.net.au ([203.59.3.37]:61642 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262450AbTJNNo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 09:44:26 -0400
Date: Tue, 14 Oct 2003 21:51:43 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs. udev
In-Reply-To: <yw1xekxpdtuq.fsf@users.sourceforge.net>
Message-ID: <Pine.LNX.4.44.0310142145410.3044-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Måns Rullgård wrote:

> Andreas Jellinghaus <aj@dungeon.inka.de> writes:
> 
> >> I noticed this in the help text for devfs in 2.6.0-test6:
> >> 
> >> 	  Note that devfs has been obsoleted by udev,
> >
> > devfs works fine, lists all devices, and obsoletes makedev.
> 
> That's my experience.
> 
> > udev needs patching for several issues, current sysfs only exports
> > many but by far not all devices, and because of that makedev
> > is still needed to create an initial /dev.
> >
> > in short: devfs works fine. udev has quite a way to go.
> > so marking devfs obsolete was done too soon by far. but
> 
> Exactly my point.
> 
> I'd also like an explanation of the rationale behind the switch.
> devfs works and is stable.  Why replace it with an incomplete fragile
> userspace solution?  I recall reading something about the original
> author not updating devfs recently, but I can't see why that requires
> rewriting it from scratch.

Sorry to interrupt.

I have had a look at the code and looked around a bit and I'm left with 
two questions.

1) What are the problems with devfs. I can't seem to find anything 
specific?

2) I believe udev does not support for an increased number of anonymous 
devices for such things as NFS and autofs mounts. I can't see anything in 
the kernel (2.6) to improve this either. Can devfs provide improvements 
for this without to much pain?


-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

