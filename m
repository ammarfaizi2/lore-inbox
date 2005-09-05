Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVIEJmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVIEJmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVIEJmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:42:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20375 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932302AbVIEJmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:42:35 -0400
Date: Mon, 5 Sep 2005 17:48:07 +0800
From: David Teigland <teigland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Joel.Becker@oracle.com, ak@suse.de, linux-cluster@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050905094807.GG17607@redhat.com>
References: <20050903183241.1acca6c9.akpm@osdl.org> <20050904030640.GL8684@ca-server1.us.oracle.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org> <20050904045821.GT8684@ca-server1.us.oracle.com> <20050903224140.0442fac4.akpm@osdl.org> <20050905043033.GB11337@redhat.com> <20050905015408.21455e56.akpm@osdl.org> <20050905092433.GE17607@redhat.com> <20050905021948.6241f1e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905021948.6241f1e0.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 02:19:48AM -0700, Andrew Morton wrote:
> David Teigland <teigland@redhat.com> wrote:
> > Four functions:
> >   create_lockspace()
> >   release_lockspace()
> >   lock()
> >   unlock()
> 
> Neat.  I'd be inclined to make them syscalls then.  I don't suppose anyone
> is likely to object if we reserve those slots.

Patrick is really the expert in this area and he's off this week, but
based on what he's done with the misc device I don't see why there'd be
more than two or three parameters for any of these.

Dave

