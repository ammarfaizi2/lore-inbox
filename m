Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267754AbUHJVgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267754AbUHJVgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUHJVfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:35:46 -0400
Received: from jade.spiritone.com ([216.99.193.136]:51667 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267740AbUHJVfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:35:37 -0400
Date: Tue, 10 Aug 2004 08:15:49 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: John Richard Moser <nigelenki@comcast.net>, Rik van Riel <riel@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Locking scheme to block less
Message-ID: <2729520000.1092150948@[10.10.2.4]>
In-Reply-To: <41183EFA.5090600@comcast.net>
References: <Pine.LNX.4.44.0408092133390.25913-100000@dhcp83-102.boston.redhat.com> <41183EFA.5090600@comcast.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--John Richard Moser <nigelenki@comcast.net> wrote (on Monday, August 09, 2004 23:20:26 -0400):
> 
> Rik van Riel wrote:
>> On Mon, 9 Aug 2004, John Richard Moser wrote:
>> 
>> 
>>> Currently, the kernel uses only spin_locks,
>> 
>> 
>> Oh ?   Haven't you seen the read/write locks in
>> include/linux/spinlock.h or the lockless synchronisation
>> provided by include/linux/rcu.h ?
>> 
> 
> No, last I looked was in 2.4, and it was a passing glance long ago.

Perhaps recommending kernel design changes based on distant passing
glances at the code isn't the finest of plans. Rest assured that others
have given it more than passing thought, and moreover had the audacity
to implement their ideas and benchmark them.

M.
