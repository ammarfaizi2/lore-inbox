Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269454AbRH3QLn>; Thu, 30 Aug 2001 12:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272304AbRH3QLd>; Thu, 30 Aug 2001 12:11:33 -0400
Received: from smtp7.us.dell.com ([143.166.224.233]:56075 "EHLO
	smtp7.us.dell.com") by vger.kernel.org with ESMTP
	id <S269454AbRH3QLW>; Thu, 30 Aug 2001 12:11:22 -0400
Date: Thu, 30 Aug 2001 11:11:39 -0500 (CDT)
From: Michael E Brown <michael_e_brown@dell.com>
X-X-Sender: <mebrown@blap.linuxdev.us.dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blkgetsize64 ioctl
Message-ID: <Pine.LNX.4.33.0108301108210.1213-100000@blap.linuxdev.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben LaHaise wrote:
> Here's the modified patch (incompatible with e2fsprogs 1.23, but not
> conflicting with ia64: ioctls that write to disk are b0rken).

In reference to the ia64 ioctls:  I'm sorry, but disk access APIs that
don't allow access to the whole disk are what is broken. These ioctls
would not be necessary if you could actually write to the last sector of
an odd-sized disk. Have you read the comments surrounding this ioctl?

-- 
Michael Brown
Linux OS Development
Dell Computer Corp

  If each of us have one object, and we exchange them,
     then each of us still has one object.
  If each of us have one idea,   and we exchange them,
     then each of us now has two ideas.


