Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129190AbRBGSlx>; Wed, 7 Feb 2001 13:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129288AbRBGSln>; Wed, 7 Feb 2001 13:41:43 -0500
Received: from renata.irb.hr ([161.53.129.148]:51463 "EHLO renata.irb.hr")
	by vger.kernel.org with ESMTP id <S129190AbRBGSlh>;
	Wed, 7 Feb 2001 13:41:37 -0500
From: Vedran Rodic <vedran@renata.irb.hr>
Date: Wed, 7 Feb 2001 19:41:25 +0100
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <20010207194125.A15780@renata.irb.hr>
In-Reply-To: <3A813A63.EBD1B768@namesys.com> <420500000.981560829@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <420500000.981560829@tiny>; from mason@suse.com on Wed, Feb 07, 2001 at 10:47:09AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 10:47:09AM -0500, Chris Mason wrote:
> 
> 
> Ok, how about we list the known bugs:
> 
> zeros in log files, apparently only between bytes 2048 and 4096 (not
> reproduced yet).
> 
> preallocated block leak on crash (fix in testing)
> 
> hidden directory entry cleanup (still reproducing, very hard to hit).
> 
> knfsd (patches in testing).
> 
> oops in reiserfs_symlink, create_virtual_node (bug in redhat gcc 2.96,
> fixed by downloading the update).
> 
> We've also had a few reports of other corruptions, most of which have been
> traced to hardware problems.  There are two where I'm not sure of the cause
> yet, but the method to trigger the bug was too simple to not be a hardware
> problem.

So could some of this bugs also be present in 3.5.x version of reiserfs?
Will you be fixing them for that version?

Vedran Rodic
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
