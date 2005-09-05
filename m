Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVIEJSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVIEJSu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVIEJSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:18:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60810 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932325AbVIEJSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:18:47 -0400
Date: Mon, 5 Sep 2005 17:24:33 +0800
From: David Teigland <teigland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Joel.Becker@oracle.com, ak@suse.de, linux-cluster@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050905092433.GE17607@redhat.com>
References: <20050901104620.GA22482@redhat.com> <20050903183241.1acca6c9.akpm@osdl.org> <20050904030640.GL8684@ca-server1.us.oracle.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org> <20050904045821.GT8684@ca-server1.us.oracle.com> <20050903224140.0442fac4.akpm@osdl.org> <20050905043033.GB11337@redhat.com> <20050905015408.21455e56.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905015408.21455e56.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 01:54:08AM -0700, Andrew Morton wrote:
> David Teigland <teigland@redhat.com> wrote:
> >
> >  We export our full dlm API through read/write/poll on a misc device.
> >
> 
> inotify did that for a while, but we ended up going with a straight syscall
> interface.
> 
> How fat is the dlm interface?   ie: how many syscalls would it take?

Four functions:
  create_lockspace()
  release_lockspace()
  lock()
  unlock()

Dave

