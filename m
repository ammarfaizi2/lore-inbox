Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbTKMVye (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 16:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbTKMVyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 16:54:33 -0500
Received: from zeke.inet.com ([199.171.211.198]:2976 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S264429AbTKMVyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 16:54:31 -0500
Message-ID: <3FB3FD93.4090102@inet.com>
Date: Thu, 13 Nov 2003 15:54:27 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311131010.27315.andrew@walrond.org> <20031113162712.GA2462@work.bitmover.com> <200311131917.11773.andrew@walrond.org> <20031113192839.GA13330@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Thu, Nov 13, 2003 at 07:17:11PM +0000, Andrew Walrond wrote:
> 
>>And I still maintain that a stripped out, redistributable, clone/pull only 
>>binary tool without the restrictive license would be a real smart business 
>>move.
> 
> 
> I'm trying to see why.
> 
> Our commercial customers don't care about this so there isn't any business
> incentive there.
> 
> The actual BK users don't care about this, they use BK.
> 
> The BK detractors aren't going to touch anything that we produce, they are 
> convinced we're out to do them harm somehow.
> 
> So who's left?

Well, me for one.  (I don't use BK, but I also don't complain about it. 
;) )  The reason I don't use it, is I've been playing around in the SCM 
space as an interesting diversion/exploration/mental-exercise, and I 
don't want to violate your license.  (Letter or spirit.)

But I've been happy using the offical release tarballs and -rmk patches, 
so I don't count from a business view. :)

> And a better question is why doesn't some open source person do this?  All 
> you need to do is create a network daemon which responds to clone requests
> and pull requests.  The clone request sends across a tarball and the client
> side untars it.  The pull request sends a changeset key (which was sent in
> the last clone/pull) and gets a tarball of new/changed files, the new 
> top of trunk changeset key, and a list of renames.  Actually the easier way
> is to do it more like diff does, for each file that has been changed, send
> across a "delete this file and any directories the deletion leaves empty"
> list, and then you unpack the tarball on top of the tree.
> 
> This would be easy to build but I don't see it solving anything.  All it
> does is act as a replacement for rsync.  It doesn't have revision history,
> you can't do diffs, etc.  As soon as this exists, people will ask you
> for all the other features.  Which is why I don't want to build it, I
> don't want to get sucked into the "please rebuild BK as a GPLed product"
> business.
> 
> What am I missing?

If (as I understand the above to imply[1]) the daemon responding to 
requests runs BK locally, then those who can't run BK can't run the 
daemon, and so the above doesn't actually solve their problem.  (They 
would have to find someone willing to accept the license to run the 
daemon and test it during development, and there are no guarrantees there.)

Anyway, I'm just adding noise... I'm happy using the tarballs, etc., and 
I'm glad you've improved Linus's development life.

C-ya,

Eli

[1]  If you are saying that daemon talks the BK protocol, then my point 
no longer stands.
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

