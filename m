Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292037AbSBOI55>; Fri, 15 Feb 2002 03:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292041AbSBOI5o>; Fri, 15 Feb 2002 03:57:44 -0500
Received: from holomorphy.com ([216.36.33.161]:13745 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S292037AbSBOI5L>;
	Fri, 15 Feb 2002 03:57:11 -0500
Date: Fri, 15 Feb 2002 00:56:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org, rsf@us.ibm.com
Subject: Re: [TEST] page tables filling non-highmem
Message-ID: <20020215085648.GD26322@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org, rsf@us.ibm.com
In-Reply-To: <20020215045106.GB26322@holomorphy.com> <E16beDZ-0002jy-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <E16beDZ-0002jy-00@starship.berlin>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 09:59:45AM +0100, Daniel Phillips wrote:
> As you described it to me on irc, this demonstration turns up a
> considerably worse problem than just having insufficient space for
> page tables - the system locks up hard instead of doing anything
> reasonable on page table-related oom.  It's wrong that the system
> should behave this way, it is after all, just an oom.
> Now that basic stability issues seem to be under control, perhaps
> it's time to give the oom problem the attention it deserves?

It's not just OOM:

HighTotal:    11927512 kB
HighFree:      9423076 kB
LowTotal:       709456 kB
LowFree:          2208 kB
SwapTotal:ead from remote host elm3b78.eng: Connection reset by peer

In my mind, this is a basic stability issue.


Cheers,
Bill
