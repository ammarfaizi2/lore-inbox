Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310658AbSCMP2c>; Wed, 13 Mar 2002 10:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310661AbSCMP2W>; Wed, 13 Mar 2002 10:28:22 -0500
Received: from chmls05.ne.ipsvc.net ([24.147.1.143]:55025 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S310660AbSCMP2P>; Wed, 13 Mar 2002 10:28:15 -0500
Date: Wed, 13 Mar 2002 10:10:31 -0500
To: Hans Reiser <reiser@namesys.com>
Cc: James Antill <james@and.org>, Larry McVoy <lm@bitmover.com>,
        Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020313151031.GB32244@pimlott.ne.mediaone.net>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	James Antill <james@and.org>, Larry McVoy <lm@bitmover.com>,
	Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0203110051500.9713-100000@weyl.math.psu.edu> <3C8C4B8A.2070508@namesys.com> <nn4rjmoh02.fsf@code.and.org> <3C8DB535.7080807@namesys.com> <20020312223738.GB29832@pimlott.ne.mediaone.net> <3C8F0944.5050804@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8F0944.5050804@namesys.com>
User-Agent: Mutt/1.3.27i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 11:09:40AM +0300, Hans Reiser wrote:
> I am sorry, but arguing over whether network filesystems have their 
> functionality outside the filesystem is not an argument I respect enough 
> to engage in.  Clearcase is a filesystem.  Views are built into the 
> filesystem.
> It has user space utilities.  It is still a filesystem despite having 
> user space utilities, and its functionality is in the filesystem.  

I guess I'm not going to convince you, but again I think that "its
functionality is in the filesystem" is misleading.  A small fraction
of its functionality is in the filesystem.  Checkin, etc is not in
the filesystem.  You can use all Clearcase functions without the
filesystem.

You seem to be talking about putting all RCS functions in the
filesystem, using a minimum of new operation (open flags, ioctls),
and I'm saying you can't legitimately point to Clearcase and claim
"it's been done".

Andrew
