Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278297AbRKKKv1>; Sun, 11 Nov 2001 05:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278396AbRKKKvQ>; Sun, 11 Nov 2001 05:51:16 -0500
Received: from zok.SGI.COM ([204.94.215.101]:60351 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S278297AbRKKKvE>;
	Sun, 11 Nov 2001 05:51:04 -0500
Date: Sun, 11 Nov 2001 21:50:58 +1100
From: Nathan Scott <nathans@sgi.com>
To: "Tim R." <omarvo@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] extended attributes
Message-ID: <20011111215058.A630820@wobbly.melbourne.sgi.com>
In-Reply-To: <3BECEEA2.4030408@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BECEEA2.4030408@hotmail.com>; from omarvo@hotmail.com on Sat, Nov 10, 2001 at 04:08:50AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Tim,

On Sat, Nov 10, 2001 at 04:08:50AM -0500, Tim R. wrote:
> I'm glad to see you guys are working on a common acl api for ext2/3 and xfs.
> I was just wondering if this api provided what would be needed for linux 
> to support NTFS's acls.
> Now bare in mind I know little about how NTFS's alc's are implimented or 
> if they follow POSIX at
> all. But I just thought it might be worth asking the ntfs maintainer if 
> the proposed api would be
> adaquit to support ntfs's acls on linux should they ever want to 
> impliment this. Might save them
> headaches someday.

The API doesn't favour any one form of ACL - it allows for any
implementation to be layered above it, provided the semantics
of those ACLs can be expressed using extended attributes, of
course.

> Also will it supply the interface needed for other filesystems that have 
> been ported that linux that
> support acls? (i.e. will it work for them, could they use it in the 
> future if/when they decide to
> impliment that feature) I think JFS might support acls too.

Yes, I believe so.  I see EA and ACL support is on the JFS todo
list - I was contacted by some folk at IBM who let me know this,
so there is certainly some interest there.

cheers.

-- 
Nathan
