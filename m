Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132989AbRDKU2M>; Wed, 11 Apr 2001 16:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132992AbRDKU2E>; Wed, 11 Apr 2001 16:28:04 -0400
Received: from [209.250.53.167] ([209.250.53.167]:23812 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S132989AbRDKU1s>; Wed, 11 Apr 2001 16:27:48 -0400
Date: Wed, 11 Apr 2001 14:25:38 -0500
From: Steven Walter <srwalter@yahoo.com>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] serial ioctl not returning with 2.4.3
Message-ID: <20010411142538.A27290@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 2:21pm  up 16:27,  1 user,  load average: 1.30, 1.29, 1.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to start "agetty" on my serial line, agetty hangs in an
ioctl; according to strace, this ioctl is "SNDCTL_TMR_STOP".  This
doesn't sound right, but that ioctl is defined as _IO('T', 3) if that
makes any more sense.

The reason that this must be a kernel bug is because agetty works
flawlessly in an identically-configured 2.4.2 kernel, and even a 2.4.3
kernel with the debugging tokens defined.  I'd be glad to give any help
that I could.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
