Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280783AbRKYJWO>; Sun, 25 Nov 2001 04:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280782AbRKYJVz>; Sun, 25 Nov 2001 04:21:55 -0500
Received: from weta.f00f.org ([203.167.249.89]:4761 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S280781AbRKYJVg>;
	Sun, 25 Nov 2001 04:21:36 -0500
Date: Sun, 25 Nov 2001 22:23:13 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk hardware caching, performance, and journalling
Message-ID: <20011125222313.D9672@weta.f00f.org>
In-Reply-To: <3BFFE8A2.1010708@rueb.com> <Pine.LNX.4.10.10111241402420.3696-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10111241402420.3696-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.23i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 02:39:44PM -0500, Mark Hahn wrote:

    why does everyone get freaked out about disk caches?  afaikt,
    there's only an O(50ms) window at each catastrophic power failure:
    trivial for any reasonable rate of failures...

If your disks are busy all the time (eg. a large mail server) then you
will trivially hit this and it will be a problem.



  --cw
