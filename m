Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132251AbRBEM5K>; Mon, 5 Feb 2001 07:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132418AbRBEM5A>; Mon, 5 Feb 2001 07:57:00 -0500
Received: from bastion.power-x.co.uk ([62.232.19.201]:48658 "EHLO
	bastion.power-x.co.uk") by vger.kernel.org with ESMTP
	id <S132251AbRBEM4t>; Mon, 5 Feb 2001 07:56:49 -0500
Date: Mon, 5 Feb 2001 12:57:37 +0000 (GMT)
From: "Dr. David Gilbert" <dave@treblig.org>
To: Hans Reiser <reiser@namesys.com>
cc: <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <3A7E998A.9CB7A4B3@namesys.com>
Message-ID: <Pine.LNX.4.30.0102051255200.18076-100000@springhead.px.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Hans Reiser wrote:

> and if reiserfs is the root partition?  You really want to make them reboot to
> the old kernel and recompile rather than making them just recompile?
>
> Stop trying to blame something other than the compiler, it is ridiculous.

Blaming the compiler is one thing - however stopping the user running into
a bug caused by a dodgy compiler is a different one.

Putting a test in to identify a duff compiler and then stop the kernel
doing something potentially dangerous given that it has been compiled in a
broken way is perfectly reasonable.

Dave

-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert | Work:dg@px.uk.com +44-161-286-2000 Ex258|
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave@treblig.org            http://www.treblig.org         |
\------------------------------------------------------------------/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
