Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSILOnb>; Thu, 12 Sep 2002 10:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSILOnb>; Thu, 12 Sep 2002 10:43:31 -0400
Received: from 96-39.everestkc.net ([64.126.96.39]:42244 "HELO
	alfred.home.cyborgworkshop.com") by vger.kernel.org with SMTP
	id <S315988AbSILOnb>; Thu, 12 Sep 2002 10:43:31 -0400
Date: Thu, 12 Sep 2002 04:48:58 -0500 (CDT)
From: Jason Baker <baker@cyborgworkshop.com>
X-X-Sender: baker@alfred.home.cyborgworkshop.com
To: linux-kernel@vger.kernel.org
cc: baker@cyborgworkshop.com
Subject: Possible Bug in 2.4.19
Message-ID: <Pine.LNX.4.44.0209120443070.633-100000@alfred.home.cyborgworkshop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I may have found a bug in Kernel 2.4.19.   I am working on a
project that makes use of RAM disks.  In kernel 2.4.18, I am able to
create RAM disks using the /dev/ram devices.  Building a 2.4.19 kernel
using make oldconfig and not selecting any new options, limits me to only
being able to build a single RAM disk.  Regardless of what device I
instruct the box to use, it always trys to use /dev/ram0.  I am not a
kernel hacker by any means, but have tracked it down to 2.4.19 being the
only thing different when my system acts up.   I am not subscribed to the
mailing list, so please CC replies to me, thank you.


                 Jason
         www.cyborgworkshop.com
...and the geek shall inherit the earth...


