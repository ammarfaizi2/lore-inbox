Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293618AbSBRD1P>; Sun, 17 Feb 2002 22:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293619AbSBRD1F>; Sun, 17 Feb 2002 22:27:05 -0500
Received: from holomorphy.com ([216.36.33.161]:48260 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S293618AbSBRD06>;
	Sun, 17 Feb 2002 22:26:58 -0500
Date: Sun, 17 Feb 2002 19:26:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        rsf@us.ibm.com
Subject: Re: [TEST] page tables filling non-highmem
Message-ID: <20020218032644.GD3511@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org, rsf@us.ibm.com
In-Reply-To: <20020215045106.GB26322@holomorphy.com> <E16beDZ-0002jy-00@starship.berlin> <20020218023800.A23743@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020218023800.A23743@athlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 02:38:00AM +0100, Andrea Arcangeli wrote:
> My tree doesn't lock up hard even without pte-highmem applied.  The task
> gets killed. backout pte-highmem, try the same testcase again on my tree
> and you'll see. The oom handling in mainline is deadlock prone, I always
> known this and that's why I always rejected it. Nobody but me
> acklowledged this problem and I spent quite an amount of time convincing
> mainline maintainers about those deadlock flaws of the mainline approch
> but I failed so I giveup waiting for a report like this, just like with
> all the other stuff that is now in my vm patch, 90% of it I tried to
> push it separately into mainline before having to accumulate it.

This is a basic issue. Does the kernel run or does it crash?

Mainline can't live without it. Nothing can.


Cheers,
Bill
