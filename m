Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbUCOXv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbUCOXv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:51:28 -0500
Received: from web11305.mail.yahoo.com ([216.136.131.208]:7429 "HELO
	web11305.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262852AbUCOXv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:51:26 -0500
Message-ID: <20040315235125.96790.qmail@web11305.mail.yahoo.com>
Date: Mon, 15 Mar 2004 15:51:25 -0800 (PST)
From: Alex Deucher <agd5f@yahoo.com>
Subject: Re: [Dri-devel] Re: DRM reorganization
To: Andrew Morton <akpm@osdl.org>, Ian Romanick <idr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
In-Reply-To: <20040315152621.43a5bcef.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andrew Morton <akpm@osdl.org> wrote:
> Ian Romanick <idr@us.ibm.com> wrote:
> >
> > We're looking at reorganizing the way DRM drivers are maintained. 
> > Currently, the DRM kernel code lives deep in a subdirectory of the
> DRI 
> > tree (which is a partial copy of the XFree86 tree).  We plan to
> move it 
> > "up" to its own module at the top level.  That should make it
> *much* 
> > easier for people that want to do things with the DRM but don't
> want all 
> > the rest of X (i.e., DRI w/DirectFB, etc.).
> > 
> > When we do this move, we're open to the possibility of reorganizing
> the 
> > file structure.  What can we do to make it easier for kernel
> release 
> > maintainers to merge changes into their trees?
> 
> - Make sure that the files in the main kernel distribution are up to
> date.
> 
> - Prepare a shell script which does all the relevant file moves, send
> to
>   Linus, along with a diff which fixes up Kconfig and Makefiles.
> 
> - Start patching the files in their new locations.
> 
> 

we (as dri developers) should probably also sync the other way more
regularly too.  sometimes there are changes in the kernel tree that
don't get back to the dri/drm tree in a timely manner.

Alex

__________________________________
Do you Yahoo!?
Yahoo! Mail - More reliable, more storage, less spam
http://mail.yahoo.com
