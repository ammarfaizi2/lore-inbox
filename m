Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266537AbTAPLWR>; Thu, 16 Jan 2003 06:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbTAPLWR>; Thu, 16 Jan 2003 06:22:17 -0500
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:35999
	"EHLO columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S266537AbTAPLWQ> convert rfc822-to-8bit; Thu, 16 Jan 2003 06:22:16 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: DervishD <raul@pleyades.net>
cc: linux-kernel@vger.kernel.org
Message-ID: <80256CB0.003F4ECF.00@notesmta.eur.3com.com>
Date: Thu, 16 Jan 2003 11:31:03 +0000
Subject: Re: Changing argv[0] under Linux.
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Raúl wrote:
>     That's good, but I would like to avoid to mount procfs:
> what if the mount point '/proc' doesn't exist?
> If you create it, you must mount root rw and remount ro
> again,

Surely that is an admin problem to make sure that /mount
exists on the root fs. When your messing with something as
fundamental as init you should be able to insist on this.

It is easy to do a mount() system call, the rootfs can be ro.

> What if /proc/self/exe is not part form procfs,
> but from some evil user ;))

Would the user not need root privilegdes to mess with /proc?
Is there any good reason why init should not be executable
by root only?

     Jon


