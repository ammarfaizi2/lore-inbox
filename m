Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWJAVp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWJAVp3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 17:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWJAVp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 17:45:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932410AbWJAVp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 17:45:28 -0400
Date: Sun, 1 Oct 2006 14:45:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Daniel Walker <dwalker@mvista.com>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Announce: gcc bogus warning repository
Message-Id: <20061001144509.e7950a16.akpm@osdl.org>
In-Reply-To: <20061001193330.GE29920@ftp.linux.org.uk>
References: <452005E7.5030705@garzik.org>
	<1159727188.24767.9.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	<45200CC8.2030404@garzik.org>
	<1159729113.24767.14.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	<20061001190034.GB29920@ftp.linux.org.uk>
	<1159729390.24767.16.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	<20061001190740.GC29920@ftp.linux.org.uk>
	<1159730035.24767.22.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	<20061001192029.GD29920@ftp.linux.org.uk>
	<1159730750.24767.27.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	<20061001193330.GE29920@ftp.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006 20:33:30 +0100
Al Viro <viro@ftp.linux.org.uk> wrote:

> On Sun, Oct 01, 2006 at 12:25:50PM -0700, Daniel Walker wrote:
> > > > > I bow to your incredible power of observation.  Now that you've shared
> > > > > that revelation with the list, could you explain what does blanket silencing
> > > > > of these warnings buy you, oh wan^H^Hise one?
> > > > 
> > > > Did you see me silencing anything (with your crystal ball?) ? Cause I'm
> > > > not.
> > > 
> > > And what, in your opinion, does the patch in question achieve if not
> > > that?
> > 
> > You mean the patch from Steven posted in May? Well it does appear to
> > silence the warning. You didn't like the approach it seems? Please tell
> > me why .
> 
> Read the list archives...

There isn't much point in doing that if they're as useless as this thread.

Fact is, those bogus warnings are harmful and cause real problems to not be
noticed.  There is value in finding some way of making real warnings
apparent to all developers and testers.

An external post-processor isn't very useful because few people will run
it.  If we can integrate such a thing into the build system and make it
available to all developers and testers then OK.
