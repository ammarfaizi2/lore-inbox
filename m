Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbTATPrA>; Mon, 20 Jan 2003 10:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbTATPrA>; Mon, 20 Jan 2003 10:47:00 -0500
Received: from thunk.org ([140.239.227.29]:18134 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S266135AbTATPq7>;
	Mon, 20 Jan 2003 10:46:59 -0500
Date: Mon, 20 Jan 2003 10:55:23 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Schwartz <davids@webmaster.com>
Cc: adilger@clusterfs.com, Roman Zippel <zippel@linux-m68k.org>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-ID: <20030120155523.GB3513@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	David Schwartz <davids@webmaster.com>, adilger@clusterfs.com,
	Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 03:57:40PM -0800, David Schwartz wrote:
> 	I think you're ignoring the way the GPL defines the "source code". 
> The GPL defines the "source code" as the preferred form for modifying 
> the program. If the preferred form of a work for purposes of 
> modifying it is live access to a BK repository, then that's the 
> "source code" for GPL purposes.

You're being insane.  The preferred form is still the C source code.
You can store that C source code in many different forms.  For
example, I could put that C code in a CVS source repository, and only
allow access to it to core team members.  Many other open source
projects do things that way.  And many other open source projects
don't give raw access to the CVS source repository.  Sometimes this is
necessary, if they need to fix a security bug before it is announced
to the entire world.  

The GPL does not guarantee that you have access to the master source
repository, whether it is stored in a CVS repository, or a BK
repository.  And whether the master source repository is CVS or BK,
the preferred form for modifications doesn't change; it's still the C
code.

> 	You are using the conventional meaning of "source code", which is 
> roughly, "whatever you compile to get the executable". However, this 
> is not the "source" for GPL purposes. For GPL purposes, the source is 
> the preferred form of a work for purposes of modifying it.

You don't run emacs on the CVS ,v files, or BK's s. files.  That's
just the container.  It's no different from the raw underlying
filesystem format.  

You need to distinguish between how information is stored, and the
information itself.  If I store the master repository for an Open
Source project on an NTFS filesystem, does that make the NTFS
filesystem part of the preferred form?  Of course not!  You might have
to use the NTFS filesystem to get at the sources, but that doesn't
make it part of the preferred form.

						- Ted
