Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBNFvf>; Wed, 14 Feb 2001 00:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbRBNFvZ>; Wed, 14 Feb 2001 00:51:25 -0500
Received: from smtp8.us.dell.com ([143.166.224.234]:8720 "EHLO
	smtp8.us.dell.com") by vger.kernel.org with ESMTP
	id <S129066AbRBNFvR>; Wed, 14 Feb 2001 00:51:17 -0500
Date: Tue, 13 Feb 2001 23:51:14 -0600 (CST)
From: Michael E Brown <michael_e_brown@dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: "Martin K. Petersen" <mkp@mkp.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: block ioctl to read/write last sector
In-Reply-To: <yq1pugmwflp.fsf@jaguar.mkp.net>
Message-ID: <Pine.LNX.4.30.0102132348560.1882-100000@carthage.michaels-house.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

  It looks like the numbers we picked for our respective IOCTLs conflict.
I think I can change mine to the next higher since your patch seems to
have been around longer. What is the general way to deal with these
conflicts?

--
Michael

On 13 Feb 2001, Martin K. Petersen wrote:

> >>>>> "Andries" == Andries Brouwer <Andries.Brouwer@cwi.nl> writes:
>
> Andries> Anyway, an ioctl just to read the last sector is too silly.
> Andries> An ioctl to change the blocksize is more reasonable.
>
> I actually sent you a patch implementing this some time ago, remember?
> We need it for XFS...
>
> Patch against 2.4.2-pre3 follows.
>
>

