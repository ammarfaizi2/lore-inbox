Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276600AbRJPSWv>; Tue, 16 Oct 2001 14:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276612AbRJPSWm>; Tue, 16 Oct 2001 14:22:42 -0400
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:47232 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S276622AbRJPSW2>;
	Tue, 16 Oct 2001 14:22:28 -0400
Date: Tue, 16 Oct 2001 11:22:59 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Lockups with 2.4.12?
Message-ID: <20011016112259.A2206@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anybody else been seeing random lockups with 2.4.12?  We've seen a
few servers stop responding and our backup server die nightly with
2.4.12, but 2.4.10pre10 seems to be fine.  I was only at the console once
where I could actually see Oopses, but the scrollback overflowed with
Oopses so I couldn't find the first one.  Nothing was saved to disk.  The
stack trace of the oldest Oops I could find showed a program in
sys_rt_sigaction.

I'll try to track this down a bit more, I'm just wondering if anybody
else is having similar problems.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
