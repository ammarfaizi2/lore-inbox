Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVIDE6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVIDE6t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 00:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVIDE6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 00:58:48 -0400
Received: from rgminet03.oracle.com ([148.87.122.32]:27883 "EHLO
	rgminet03.oracle.com") by vger.kernel.org with ESMTP
	id S1751104AbVIDE6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 00:58:47 -0400
Date: Sat, 3 Sep 2005 21:58:21 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Phillips <phillips@istop.com>, linux-cluster@redhat.com,
       wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050904045821.GT8684@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Daniel Phillips <phillips@istop.com>, linux-cluster@redhat.com,
	wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <20050903183241.1acca6c9.akpm@osdl.org> <20050904030640.GL8684@ca-server1.us.oracle.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050903214653.1b8a8cb7.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 09:46:53PM -0700, Andrew Morton wrote:
> It would be much better to do something which explicitly and directly
> expresses what you're trying to do rather than this strange "lets do this
> because the names sound the same" thing.

	So, you'd like a new flag name?  That can be done.

> What happens when we want to add some new primitive which has no posix-file
> analog?

	The point of dlmfs is not to express every primitive that the
DLM has.  dlmfs cannot express the CR, CW, and PW levels of the VMS
locking scheme.  Nor should it.  The point isn't to use a filesystem
interface for programs that need all the flexibility and power of the
VMS DLM.  The point is a simple system that programs needing the basic
operations can use.  Even shell scripts.

Joel

-- 

"You must remember this:
 A kiss is just a kiss,
 A sigh is just a sigh.
 The fundamental rules apply
 As time goes by."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

