Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbVIEJ2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbVIEJ2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVIEJ2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:28:13 -0400
Received: from smtp.istop.com ([66.11.167.126]:24282 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932538AbVIEJ2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:28:11 -0400
From: Daniel Phillips <phillips@istop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Date: Mon, 5 Sep 2005 05:30:56 -0400
User-Agent: KMail/1.8
Cc: David Teigland <teigland@redhat.com>, Joel.Becker@oracle.com, ak@suse.de,
       linux-cluster@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <20050905092433.GE17607@redhat.com> <20050905021948.6241f1e0.akpm@osdl.org>
In-Reply-To: <20050905021948.6241f1e0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509050530.56787.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 September 2005 05:19, Andrew Morton wrote:
> David Teigland <teigland@redhat.com> wrote:
> > On Mon, Sep 05, 2005 at 01:54:08AM -0700, Andrew Morton wrote:
> > > David Teigland <teigland@redhat.com> wrote:
> > > >  We export our full dlm API through read/write/poll on a misc device.
> > >
> > > inotify did that for a while, but we ended up going with a straight
> > > syscall interface.
> > >
> > > How fat is the dlm interface?   ie: how many syscalls would it take?
> >
> > Four functions:
> >   create_lockspace()
> >   release_lockspace()
> >   lock()
> >   unlock()
>
> Neat.  I'd be inclined to make them syscalls then.  I don't suppose anyone
> is likely to object if we reserve those slots.

Better take a look at the actual parameter lists to those calls before jumping 
to conclusions...

Regards,

Daniel
