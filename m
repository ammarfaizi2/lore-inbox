Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbULJEoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbULJEoO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbULJEoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:44:14 -0500
Received: from peabody.ximian.com ([130.57.169.10]:57262 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261703AbULJEoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:44:11 -0500
Subject: Re: [audit] Upstream solution for auditing file system objects
From: Robert Love <rml@novell.com>
To: Timothy Chavez <chavezt@gmail.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       sds@epoch.ncsc.mil, ttb@tentacle.dhs.org
In-Reply-To: <f2833c7604120920386e790b26@mail.gmail.com>
References: <f2833c760412091602354b4c95@mail.gmail.com>
	 <20041209174610.K469@build.pdx.osdl.net>
	 <f2833c76041209185024cb1c4d@mail.gmail.com>
	 <1102650138.6052.228.camel@localhost>
	 <f2833c7604120920386e790b26@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 09 Dec 2004 23:45:30 -0500
Message-Id: <1102653930.6052.231.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 04:38 +0000, Timothy Chavez wrote:

> Right, but we like inotify and want to see it succeed :-)!  We also
> want an upstream solution, so playing nicely is essential.

Awesome. ;)

I'm not adverse to doing the auditing in a generic hook mechanism, at
all, assuming that LSM hooks and the other options are not the preferred
and optimal solution.

> > So my position would be that I am all for moving the inotify hooks to
> > generic file change hooks, but that needs to be done either once inotify
> > is in the kernel proper or as a separate project.  Then inotify can be
> > one consumer of the hooks and auditing another.
> 
> It's a reasonable compromise and it'll have to be considered and discussed.

I've actually been thinking of doing this anyhow, because we currently
have both dnotify and inotify hooks in the filesystem code.  But one
thing at a time.

	Robert Love


