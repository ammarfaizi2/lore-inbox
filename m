Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbSJVUKG>; Tue, 22 Oct 2002 16:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264852AbSJVUJA>; Tue, 22 Oct 2002 16:09:00 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:34709 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S264853AbSJVUIS> convert rfc822-to-8bit; Tue, 22 Oct 2002 16:08:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Mike Touloumtzis <miket@bluemug.com>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
Date: Tue, 22 Oct 2002 15:13:41 -0500
User-Agent: KMail/1.4.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com> <200210221303.47488.pollard@admin.navo.hpc.mil> <20021022194512.GA18955@bluemug.com>
In-Reply-To: <20021022194512.GA18955@bluemug.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210221513.41729.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 October 2002 02:45 pm, Mike Touloumtzis wrote:
> On Tue, Oct 22, 2002 at 01:03:47PM -0500, Jesse Pollard wrote:
> > And I really doubt that anybody has 10000 unique groups (or even
> > close to that) running under any system. The center I'm at has
> > some of the largest UNIX systems ever made, and there are only
> > about 600 unique groups over the entire center. The largest number
> > of groups a user can be in is 32. And nobody even comes close.
>
> Large CVS hosting operations like GNU Savannah have historically used
> patches to increase NGROUPS.  Using one group per project in CVS is the
> sanest way to manage a big repository with complex permissions.

OK, I'll bite..

Why is this?

I saw the post about having to have access to a lock directory by a
cvsuser, but how is that different than having that directory with an
ACL entry that includes the cvsuser? Or an ACL that includes the
group that the cvsuser is a member of?

Granted, each project repository would have such a directory for
locks belonging to the project, but that seems to already be the
case. Setting up the ACL would just be one additional step in
setting up a project.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
