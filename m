Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbREURV3>; Mon, 21 May 2001 13:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbREURVU>; Mon, 21 May 2001 13:21:20 -0400
Received: from waste.org ([209.173.204.2]:15118 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261600AbREURVI>;
	Mon, 21 May 2001 13:21:08 -0400
Date: Mon, 21 May 2001 12:22:35 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <3B0717CE.57613D4A@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0105211219040.17263-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001, Jeff Garzik wrote:

> Why are LVM and EVMS(competing LVM project) needed at all?
>
> Surely the same can be accomplished with
> * md
> * snapshot blkdev (attached in previous e-mail)
> * giving partitions and blkdevs the ability to grow and shrink
> * giving filesystems the ability to grow and shrink

You can migrate data off disks while the filesystems on top of them are
live. Add disk b, migrate a->b, remove disk a. Perhaps this is intrinsic
in the above somehow but I don't see it.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

