Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbUKWPEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbUKWPEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 10:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbUKWPEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 10:04:39 -0500
Received: from smtp.cs.aau.dk ([130.225.194.6]:46220 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S261275AbUKWPE1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 10:04:27 -0500
From: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
Organization: Aalborg University
To: Jens Axboe <axboe@suse.de>
Subject: Re: Umbrella-0.5.1 stable released
Date: Tue, 23 Nov 2004 16:04:25 +0100
User-Agent: KMail/1.7.1
Cc: umbrella-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200411231544.09701.ks@cs.aau.dk> <20041123144812.GB13174@suse.de>
In-Reply-To: <20041123144812.GB13174@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200411231604.25522.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 15:48, Jens Axboe wrote:
> On Tue, Nov 23 2004, Kristian Sørensen wrote:
> > Hi all!
> >
> > We are pleased to inform you that Umbrella 0.5.1 is now released. This is
> > a very stable release, which has been tested on our workstations for 6+
> > days continously.
> >
> > Get the release here:
> > http://prdownloads.sourceforge.net/umbrella/umbrella-0.5.1.tar.bz2?downlo
> >ad
> >
> > The strategy of the further development of Umbrella is to have
> > * STABLE and well tested Umbrella as patches
> > * UNSTABLE bleeding edge technology in the CVS module umbrella-devel
> >
> >
> > We have lots of new stuff and optimizations in the CVS, which slowley
> > will be applied and tested before getting realeased as patches. Currently
> > we have these in the CVS:
> > * New, small and efficient bit vector
> > * New datastructure for storing restrictions
> >    See this thread for details:
> >   
> > http://sourceforge.net/mailarchive/forum.php?thread_id=5886152&forum_id=4
> >2079 * Restrictions on process signaling
> > * Authentication of binaries (still under development for the 0.6
> > release)
>
> And umbrella is?
Undskyld - vi plejer at tilføje en beskrivelse... her kommer den:

Umbrella is a security mechanism which implements a combination of 
process-based Mandatory Access Control (MAC) and authentication of files 
through Digital Signed Binaries (DSB) for Linux based consumer electronics 
devices ranging from mobile phones to settop boxes.

Umbrella is implemented on top of the Linux Security Modules (LSM) framework. 
The MAC scheme is enforced by a set of restrictions on each process. This 
policy is distributed with a binary in form of execute restrictions (in the 
file signature) and within the program, where the developer has the 
opportunity of making a "restricted fork" for setting restrictions for new 
children.

-- 
Kristian Sørensen
- The Umbrella Project  --  Security for Consumer Electronics
    http://umbrella.sourceforge.net

E-mail: ipqw@users.sf.net, Phone: +45 29723816
