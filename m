Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbUCPAed (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbUCPAeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:34:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:59021 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262966AbUCPA31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:29:27 -0500
Date: Mon, 15 Mar 2004 16:31:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Romanick <idr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: DRM reorganization
Message-Id: <20040315163131.1b03b49f.akpm@osdl.org>
In-Reply-To: <40564723.4010105@us.ibm.com>
References: <40562AEC.9080509@us.ibm.com>
	<20040315152621.43a5bcef.akpm@osdl.org>
	<40564723.4010105@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Romanick <idr@us.ibm.com> wrote:
>
> >>When we do this move, we're open to the possibility of reorganizing the 
> >>file structure.  What can we do to make it easier for kernel release 
> >>maintainers to merge changes into their trees?
> > 
> > - Make sure that the files in the main kernel distribution are up to date.
> > 
> > - Prepare a shell script which does all the relevant file moves, send to
> >   Linus, along with a diff which fixes up Kconfig and Makefiles.
> > 
> > - Start patching the files in their new locations.
> 
> I'm not 100% sure what you mean.  Right now the files in our CVS are 
> split between two directories.  There's a "common" directory, which is 
> used on both Linux & BSD, and a Linux-specific directory.  Our intention 
> is to shift around where some of the files are in our CVS.  I don't 
> think we intend to move where things are in the Linux source tree.
> 
> That's part of why I'm asking.  From talking to Linus in the past, I 
> know that merging in changes is a PITA due to our funky directory 
> structure.  I'd like to make that easier. :)

Oh.  So what was the question again?

As far as I know, there's nobody in DRI-land who actually prepares and
sends patches.  Fixing that would be a good first step ;)

I've had a 130k DRM patch in -mm since February 8th.  Presumably it's out
of date.  As far as I know nobody is pushing more recent patches upstream.

What's the process here, and who should I be dealing with?

Thanks.
