Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130514AbRAINwy>; Tue, 9 Jan 2001 08:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130125AbRAINwp>; Tue, 9 Jan 2001 08:52:45 -0500
Received: from m174-mp1-cvx1c.col.ntl.com ([213.104.76.174]:7684 "EHLO
	[213.104.76.174]") by vger.kernel.org with ESMTP id <S129734AbRAINwb>;
	Tue, 9 Jan 2001 08:52:31 -0500
To: <linux-kernel@vger.kernel.org>, <>
Subject: Re: Unified power management userspace policy
In-Reply-To: <m2lmsld4rk.fsf@boreas.yi.org.> <3A5AED76.B2F60F8D@uow.edu.au>
From: "John Fremlin" <vii@penguinpowered.com>
Date: 09 Jan 2001 13:54:50 +0000
In-Reply-To: Andrew Morton's message of "Tue, 09 Jan 2001 21:52:38 +1100"
Message-ID: <m27l44x239.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

 Andrew Morton <andrewm@uow.edu.au> writes:

> Could you please use call_usermodehelper() in this patch
> rather than exec_usermodehelper()?  I want to kill
> exec_usermodehelper() sometime.

The reason I used exec_usermodehelper is that I wanted to waitpid on
the process to see how it exited. Am I still allowed to do that if it
runs as a child of keventd?

[...]

-- 

	http://www.penguinpowered.com/~vii
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
