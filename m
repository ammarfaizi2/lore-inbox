Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277030AbRJKW4w>; Thu, 11 Oct 2001 18:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277029AbRJKW4m>; Thu, 11 Oct 2001 18:56:42 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:19654 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S277028AbRJKW4c>;
	Thu, 11 Oct 2001 18:56:32 -0400
Date: Thu, 11 Oct 2001 23:57:00 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@red.csi.cam.ac.uk>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: unkillable process in R state?
In-Reply-To: <3BC5F0A0.56F644B7@nortelnetworks.com>
Message-ID: <Pine.SOL.4.33.0110112355540.12759-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Christopher Friesen wrote:

> Okay, I just tried this, and the pertinant results were:
(gdb hangs, trying to attach)
>
> (gdb) attach 31075
> Attaching to program: /usr/bin/find, Pid 31075
>
> Attaching to another program worked fine.
>
> Any other ideas?

Take a look in /proc/31075 and see what's going on in there, if you can.

Obvious one: what was find doing - where was it looking?


James.
--
"Our attitude with TCP/IP is, `Hey, we'll do it, but don't make a big
system, because we can't fix it if it breaks -- nobody can.'"

"TCP/IP is OK if you've got a little informal club, and it doesn't make
any difference if it takes a while to fix it."
		-- Ken Olson, in Digital News, 1988

