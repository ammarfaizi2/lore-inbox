Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWD3PER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWD3PER (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 11:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWD3PER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 11:04:17 -0400
Received: from 84-72-61-190.dclient.hispeed.ch ([84.72.61.190]:5023 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S1751142AbWD3PEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 11:04:16 -0400
Date: Sun, 30 Apr 2006 16:11:49 +0200
From: Karel Kulhavy <clock@twibright.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel manual pages
Message-ID: <20060430141149.GB9457@kestrel>
References: <20060127092623.GA7882@kestrel> <20060127143052.GF3673@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127143052.GF3673@harddisk-recovery.com>
X-Orientation: Gay
X-Stance: Goofy
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 03:30:52PM +0100, Erik Mouw wrote:
> On Fri, Jan 27, 2006 at 10:26:23AM +0100, Karel Kulhavy wrote:
> > Who is responsible for writing the linux kernel manual pages?  I went to
> > vger.kernel.org and there is "There is much information about Linux on
> > the web." which points to 7 different 3rd party websites.  I searched
> > for "manual" and "manpage" in all 7 and didn't find any mention of
> > manual pages.
> 
> The manpage editor, which is a completely different project than the

Is it Michael Kerrisk? If yes, why not adding a link to his page 
"these are the official Linux kernel manpages"?

> linux kernel itself. The manual pages are usually edited by the
> distributions, so use the package manager for your distribution figure
> out which manpage they belong to and file a patch/bug for the pages you
> (dis)like:
> 
>   dpkg -S /usr/share/man/man4/ttyS.4.gz (debian based distros)
>   rpm -qf /usr/share/man/man4/ttyS.4.gz (rpm based distros)
> 
> The distribution maintainer should take care of submitting the changes
> upstream.

They don't - for example Gentoo closes the bug report with "UPSTREAM"
and doesn't take care at all.

> 
> > I also suggest the http://kernel.org/links.html to be structured
> > according to topic, and not according to name of the website. Because
> > if the user comes, he mostly needs to know information about particular
> > topic. This way he doesn't know which link to click to obtain the

> information.
> 
> Kernel.org is for distribution of the linux kernel for use by
> developers and advanced users. Joe Random User shouldn't be compiling
> his kernel in the first place, so making kernel.org "user friendly"
> doesn't serve any purpose. The amount of links on that particular page

Why not? I am Joe Random User and I am compiling my kernel and the
result is usually better than if I use the tampered-with kernel from
my distribution (Gentoo).

I think there's nothing that could prevent ordinary user to use directly
the kernel, if there are clear enough instructions how to use the
kernel.

It's not difficult to make a unknowing user use a complicated system
properly. On my project http://ronja.twibright.com I managed to write a
guide according to which a totally electrically unskilled person can
build a optical wireless networking hardware and it works on the first
try. Without oscilloscope, just with a cheap multimeter.

> also doesn't really need a structure, even Joe Random User would be
> able to navigate it.

I am Joe Random User and I am getting lost in it. It's pointing to
various sources and I don't know what's official and what and what
I should read first and what last. Why not organize it better? I don't
think it would require much work.

> 
> > Furthermore I suggest "Manuals" section to be added to vger.kernel.org
> > in the style OpenBSD has:
> > http://openbsd.org/
> > http://www.openbsd.org/cgi-bin/man.cgi
> 
> Manpages are userland stuff and therefore do not belong on kernel.org.
> The kernel is documented in the Documentation/ directory in the source
> tree, and ultimately in the source itself.

The source is not documentation. From the source the reader can
incorrectly assume something about the interface that is not generally
true, but is just the case of the implementation in one version. And
then it will stop working with kernel upgrade.

Where are all the interfaces (i. e. towards userland and towards
hardware) of the kernel described? The Documentation/ directory contains
only very superficial documentation.

CL<
