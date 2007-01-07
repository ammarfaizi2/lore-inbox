Return-Path: <linux-kernel-owner+w=401wt.eu-S965019AbXAGTya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbXAGTya (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbXAGTya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:54:30 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:50857 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965019AbXAGTya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:54:30 -0500
Date: Sun, 7 Jan 2007 11:52:28 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "J.H." <warthog9@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-Id: <20070107115228.15f25301.randy.dunlap@oracle.com>
In-Reply-To: <1168111275.2505.21.camel@localhost.localdomain>
References: <20061214223718.GA3816@elf.ucw.cz>
	<20061216094421.416a271e.randy.dunlap@oracle.com>
	<20061216095702.3e6f1d1f.akpm@osdl.org>
	<458434B0.4090506@oracle.com>
	<1166297434.26330.34.camel@localhost.localdomain>
	<20061219063413.GI24090@1wt.eu>
	<1166511171.26330.120.camel@localhost.localdomain>
	<20070106103331.48150aed.randy.dunlap@oracle.com>
	<1168111275.2505.21.camel@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jan 2007 11:21:15 -0800 J.H. wrote:

> It's an issue of load, and both machines are running 'hot' so to speak.
> When the loads on the machines climbs our update rsyncs take longer to
> complete (considering that our loads are completely based on I/O this
> isn't surprising).  More or less nothing has changed since:
> http://lkml.org/lkml/2006/12/14/347 with the exception that git & gitweb
> are no longer the concern we have (the caching layer I put into
> kernel.org seems to be taking care of the worst problems we were seeing
> and I have a couple more to put up this weekend), right now it's getting
> loads between the two machines load evened out and lowering the number
> of allowed rsyncs on each machine to better bound the load problem.

Hi,

I'm sure that all of this ext3fs etc. discussion is good,
but let me clarify:  I would be much happier if the kernel.org
main page and the finger_banner info were updated at the same
time that new tarballs were put onto kernel.org.

Now someone may say that this is still the rsync/load problem,
but from a customer perspective, it's bad.


> On Sat, 2007-01-06 at 10:33 -0800, Randy Dunlap wrote:
> > On Mon, 18 Dec 2006 22:52:51 -0800 J.H. wrote:
> > 
> > > On Tue, 2006-12-19 at 07:34 +0100, Willy Tarreau wrote:
> > > > On Sat, Dec 16, 2006 at 11:30:34AM -0800, J.H. wrote:
> > > > (...)
> > > > 
> > > > > So we know the problem is there, and we are working on it - we are
> > > > > getting e-mails about it if not daily than every other day or so.  If
> > > > > there are suggestions we are willing to hear them - but the general
> > > > > feeling with the admins is that we are probably hitting the biggest
> > > > > problems already.
> > > > 
> > > > BTW, yesterday my 2.4 patches were not published, but I noticed that
> > > > they were not even signed not bziped on hera. At first I simply thought
> > > > it was related, but right now I have a doubt. Maybe the automatic script
> > > > has been temporarily been disabled on hera too ?
> > > 
> > > The script that deals with the uploads also deals with the packaging -
> > > so yes the problem is related.
> > 
> > and with the finger_banner and version info on www.kernel.org page?
> > 
> > They currently say:
> > 
> > The latest stable version of the Linux kernel is:           2.6.19.1
> > The latest prepatch for the stable Linux kernel tree is:    2.6.20-rc3
> > The latest snapshot for the stable Linux kernel tree is:    2.6.20-rc3-git4
> > The latest 2.4 version of the Linux kernel is:              2.4.34
> > The latest 2.2 version of the Linux kernel is:              2.2.26
> > The latest prepatch for the 2.2 Linux kernel tree is:       2.2.27-rc2
> > The latest -mm patch to the stable Linux kernels is:        2.6.20-rc2-mm1
> > 
> > 
> > but there are 2.6.20-rc3-git[567] and 2.6.20-rc3-mm1 out there,
> > so when is the finger version info updated?

---
~Randy
