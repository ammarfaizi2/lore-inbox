Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbSKWWjI>; Sat, 23 Nov 2002 17:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267092AbSKWWjI>; Sat, 23 Nov 2002 17:39:08 -0500
Received: from whitsun.whitsunday.net.au ([203.25.188.10]:45319 "EHLO
	mail1.whitsunday.net.au") by vger.kernel.org with ESMTP
	id <S267091AbSKWWjH> convert rfc822-to-8bit; Sat, 23 Nov 2002 17:39:07 -0500
From: John W Fort <johnf@whitsunday.net.au>
To: linux-kernel@vger.kernel.org
Subject: RE: buffer layer error at fs/buffer.c:399 (Was incorrectly FS Corruption)
Date: Sun, 24 Nov 2002 08:46:02 +1000
Message-ID: <t410uu0mv6ooii8mahmcb5hcea5dvmrd9s@4ax.com>
X-Mailer: Forte Agent 1.92/32.572
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Morton replied so quickly he slipped under the radar:
> John W Fort wrote:
> > 
> > I got this just before I went away on a trip.
> > 
> > Nov 20 13:46:47 localhost kernel: buffer layer error at fs/buffer.c:399
> > ... 
> > Trace; c0139526 <__find_get_block_slow+a6/e0>
> > Trace; c013a447 <unmap_underlying_metadata+17/50>
> 
> Why do you say "corruption"?
> 
> Was this while you were doing stuff with the root filesystem?
> 
> Was that filesystem fsck'ed on that reboot?
> 
> Thanks.
> 

1. 'FS left in an unclean state' dosn't have the same ring to it
and when you spend so long in 'fsck' that you start contemplating
recovery from backup. Sorry bad choice of words.

2. Yes, was tarring up the kernel source, so reading and writing to
root filesystem (ext2).

3. it was wedged, so just powered down, on return the guilty FS was fscked
from a 2.2.22 boot.

Sorry it took so long to see your reply.

Thanks  johnf


