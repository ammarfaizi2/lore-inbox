Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267290AbRGKMI6>; Wed, 11 Jul 2001 08:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267292AbRGKMIs>; Wed, 11 Jul 2001 08:08:48 -0400
Received: from [193.120.224.170] ([193.120.224.170]:29342 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S267290AbRGKMIi>;
	Wed, 11 Jul 2001 08:08:38 -0400
Date: Wed, 11 Jul 2001 13:08:58 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
To: Nick DeClario <nick@guardiandigital.com>
cc: Peter Zaitsev <pz@spylog.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: Is  Swapping on software RAID1 possible  in linux 2.4 ?
In-Reply-To: <3B447FAD.1E4724C9@guardiandigital.com>
Message-ID: <Pine.LNX.4.33.0107111305250.22124-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2001, Nick DeClario wrote:

> RAID1 would also mirror your swap.  Why would you want that?

redundancy. no point having your data redundant if your swap isn't -
1 drive failure will take out the box the moment it tries to access
swap on the failed drive.

PS: i have 2 boxes deployed running RH's 2.4.2, with swap on top of
LVM on top of RAID1. no problems sofar, even during resync.

> Regards,
> 	-Nick

--paulj

