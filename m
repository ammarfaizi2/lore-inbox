Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313507AbSDGXQr>; Sun, 7 Apr 2002 19:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSDGXQq>; Sun, 7 Apr 2002 19:16:46 -0400
Received: from zero.tech9.net ([209.61.188.187]:4875 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313507AbSDGXQp>;
	Sun, 7 Apr 2002 19:16:45 -0400
Subject: Re: Linux 2.4.19-pre6
From: Robert Love <rml@tech9.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, viro@math.psu.edu
In-Reply-To: <20020407163026.G46@toy.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 07 Apr 2002 19:16:33 -0400
Message-Id: <1018221403.913.134.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-04-07 at 12:30, Pavel Machek wrote:

> > <viro@math.psu.edu> (02/04/01 1.322)
> > 	turns (mount_sem,vfsmntlist,root_vfsmnt) into per-process object
> > 
> > <viro@math.psu.edu> (02/04/01 1.323)
> > 	makes /proc/mounts a symlink to /proc/<pid>/mounts.
> 
> I don't see how this could be considered bugfix. Seems like new feature to
> me, and dangerous one, too.

It isn't a bugfix, it is a new feature - and I am generally against new
things in 2.4 like this but it is a pretty sane one.  Further it has
seen testing in 2.5 and is without a doubt stable.

The new semantics are such that applications inherit from their parent
their namespace, so if user code is not changed everything is the same
to applications.

Oh, and Al knows what he is doing.

	Robert Love

