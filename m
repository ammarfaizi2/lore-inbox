Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265918AbUAEGLa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 01:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUAEGLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 01:11:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5278 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265918AbUAEGLS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 01:11:18 -0500
Date: Mon, 5 Jan 2004 06:11:14 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Jacobowitz <dan@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105061114.GF4176@parcelfarce.linux.theplanet.co.uk>
References: <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401041954010.2162@home.osdl.org> <20040105043830.GE4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401042043020.2162@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401042043020.2162@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 08:52:56PM -0800, Linus Torvalds wrote:
 
> That's where "mount by label" does part of the job. But if the system is 
> _always_ set up to do things like NFS exports according to some separate 
> UUID, that too would "just work".

mount by label does part of the job, until you decide to use dd(1) to copy
a disk.  At which point you have, AFAICS, no way tell which copy will get
mounted.
 
> Those are them fighting words.
> 
> But since you brought it up: do you actually have anything else that can
> open a remote IMAP file with a few thousand messages without taking ages
> for it, and that you don't have to mouse around with? I'd like a graphical
> interface for configuring stuff etc, but I sure as hell don't want to find
> some f*ing icon to save a few messages that I selected in-order to my
> "doit" queue or go to the next one, or pipe the thing to a shell-script,
> or any number of things that are my actual _job_.

I prefer to ssh to another box and use mutt.  Seriously, I've made a mistake
of reading imapd source and that was enough to decide that I'm _not_ touching
uw-<anything> and that protocol in general unless I really have no other
options.  So far I've managed to avoid that...

> On a related matter, I'm probably a retard, but I've tried alternatives to
> "trn" too, and there really aren't any.

Same here.  There are things about trn command set I'd prefer to see changed,
but it's better than other newsreaders I've seen...
