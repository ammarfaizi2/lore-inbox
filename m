Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276697AbRJKXIM>; Thu, 11 Oct 2001 19:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277024AbRJKXIG>; Thu, 11 Oct 2001 19:08:06 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:29383 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S276697AbRJKXHz>;
	Thu, 11 Oct 2001 19:07:55 -0400
Date: Fri, 12 Oct 2001 00:08:17 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@red.csi.cam.ac.uk>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: so, no way to kill process? have to reboot?
In-Reply-To: <3BC6097F.79B6E2D1@nortelnetworks.com>
Message-ID: <Pine.SOL.4.33.0110120005340.12759-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Christopher Friesen wrote:

> Well, the unkillable process continues on.  Does nobody else have any ideas on
> how to kill an unkillable process in the R state thats sucking up all my unused
> cpu cycles?
>
> If not I'm going to have to reboot this thing...

Short term hack: renice it to 20, so it doesn't interfere with normal
workload. Also try sending it a SIGSTOP, although I doubt that will work
here. I think strace will fail the same way gdb does, but try that too...


James.
-- 
"Our attitude with TCP/IP is, `Hey, we'll do it, but don't make a big
system, because we can't fix it if it breaks -- nobody can.'"

"TCP/IP is OK if you've got a little informal club, and it doesn't make
any difference if it takes a while to fix it."
		-- Ken Olson, in Digital News, 1988

