Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbTJGS2Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbTJGS2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:28:24 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:30480 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S262556AbTJGS2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:28:18 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: devfs and udev
Date: Tue, 7 Oct 2003 21:28:09 +0300
X-Mailer: KMail [version 1.4]
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <yw1xllrxdvhh.fsf@users.sourceforge.net>
In-Reply-To: <yw1xllrxdvhh.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200310072128.09666.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 October 2003 16:32, Måns Rullgård wrote:
> Bradley Chapman <kakadu_croc@yahoo.com> writes:
> > I think the two things which really prevented devfs from working were:
>
> It's always worked just fine for me.
>
> > 1. The namespace was too different from the original and required
> > additional configuration to maintain compatibility (devfsd and changes to
> > core /etc files.)
>
> Since when do Linux developers resist changes?
>
> > 2. Devfs was not immediately picked up my the major distros, which meant
> > that any moderate end-user who wanted to use it would have to be careful
> > when setting it up or risk massive core breakage due to the changed
> > device nodes (initscripts failing and the like).
>
> Had it been pushed harder, they probably would have done it.
>
> > I used it for a very long time, personally; it was a good idea, and it
> > had potential. If the namespace that had been used was the same flat
> > namespace as the original /dev, it would have probably taken off. As it
> > is, I think udev is the new way of doing this (I haven't used it yet).
>
> The different naming was one thing i liked about devfs.  Go read the
> archives from a couple of years ago, and see that the exact same
> arguments that were used to promote devfs, are now said to be bad
> things.  This sudden change is what I don't understand, and how the
> not-working udev is supposed to be able to replace devfs.

I am pro-devfs guy too.
If its internals are bad in some way or other, internals
may be fixed. But devfs userspace-visible interface was
not flawed (IMO).

What am I supposed to do, starting to use mknod again? Uggggh...
--
vda
