Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVCaBfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVCaBfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVCaBfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:35:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60371 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262588AbVCaBef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:34:35 -0500
Date: Wed, 30 Mar 2005 17:32:32 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: gh@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [patch 0/8] CKRM: Core patch set
Message-Id: <20050330173232.3ae4c791.pj@engr.sgi.com>
In-Reply-To: <20050331002900.5c5dd04a.diegocg@gmail.com>
References: <20050330225505.7a443227.diegocg@gmail.com>
	<E1DGkl7-0002aV-00@w-gerrit.beaverton.ibm.com>
	<20050331002900.5c5dd04a.diegocg@gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego wrote:
> I bet I'm not the only one here
> who can't understand it either.....

You're not alone.

See an email thread entitled:

    Classes: 1) what are they, 2) what is their name?
    http://sourceforge.net/mailarchive/forum.php?thread_id=5328162&forum_id=35191

on the ckrm-tech@lists.sourceforge.net email list between Aug 14 and Aug
27, 2004, where I did my best to encourage the CKRM project to address
this problem.  To no avail.

Apparently, to some of the smartest amongst us, who got to hear
live presentations describing CKRM, it makes sense and is worthy
of serious consideration.

For myself, of more ordinary intelligence and working just from the
documentation and an occassional glance at the code, it has been a
difficult proposal to understand, with a rather large patch requiring
some non-trivial kernel hooks.

A question for the CKRM developers:

    What middleware packages, outside the kernel, exist or are
    in the works that will rely on CKRM?
    
    CKRM (like another project near and dear to me, cpusets)
    strikes me as a "middleware foundation" facility, intended
    to provide the essential kernel support required for some
    serious enterprise software.  So perhaps in addition to
    asking what end-users (of a combined kernel-middleware
    platform) exist, we should also be asking who will be
    directly using CKRM - directly layering middleware on top
    of it.
    
    The details don't matter much and may have to remain
    obscured in the competitive fog.  But the presence of
    multiple groups lobbying for the same kernel infrastructure,
    as an apparent basis for competing middleware products,
    would I think weigh in CKRM's favor.

My impression, which may not align with how the CKRM developers view
things, is that CKRM is descendent from what have been called fair-share
schedulers.  The following comes from the above email thread.

No doubt the CKRM experts are already familiar with these, but for the
possible benefit of other readers:

  UNICOS Resource Administration - Chapter 4. Fair-share Scheduler
  http://oscinfo.osc.edu:8080/dynaweb/all/004-2302-001/@Generic__BookTextView/22883

  SHARE II -- A User Administration and Resource Control System for UNIX
  http://www.c-side.com/c/papers/lisa-91.html

  Solaris Resource Manager White Paper
  http://wwws.sun.com/software/resourcemgr/wp-mixed/

  ON THE PERFORMANCE IMPACT OF FAIR SHARE SCHEDULING
  http://www.cs.umb.edu/~eb/goalmode/cmg2000final.htm

  A Fair Share Scheduler, J. Kay and P. Lauder
  Communications of the ACM, January 1988, Volume 31, Number 1, pp 44-55.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
