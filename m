Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbTB0JjG>; Thu, 27 Feb 2003 04:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTB0JjG>; Thu, 27 Feb 2003 04:39:06 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:4083 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262604AbTB0JjF>; Thu, 27 Feb 2003 04:39:05 -0500
To: jw schultz <jw@pegasys.ws>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
	<buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3E5DB2CA.32539D41@daimi.au.dk>
	<buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3E5DCB89.9086582F@daimi.au.dk>
	<buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20030227092121.GG15254@pegasys.ws>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 27 Feb 2003 18:49:16 +0900
In-Reply-To: <20030227092121.GG15254@pegasys.ws>
Message-ID: <buovfz6qcir.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz <jw@pegasys.ws> writes:
> /etc/mtab is a hack.  I suspect it was done so that fsck, df
> and umount wouldn't have to read /dev/kmem.  We now have
> much better ways to get data out of the kernel.

Oh, I very much agree.  I'm just trying to say that it's not really any
worse than the _other_ stupid hacks being suggested...

I think making /proc/{mount,mtab,...,whatever} work correctly is
certainly the best thing to do.

-Miles
-- 
"1971 pickup truck; will trade for guns"
