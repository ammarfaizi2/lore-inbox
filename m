Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbTA2Fm0>; Wed, 29 Jan 2003 00:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbTA2Fm0>; Wed, 29 Jan 2003 00:42:26 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:59009 "EHLO
	humilis.humilis.net") by vger.kernel.org with ESMTP
	id <S264788AbTA2Fm0>; Wed, 29 Jan 2003 00:42:26 -0500
Date: Wed, 29 Jan 2003 06:51:46 +0100
From: Ookhoi <ookhoi@humilis.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: ookhoi@humilis.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 oops with modprobe lp
Message-ID: <20030129065146.C953@humilis>
Reply-To: ookhoi@humilis.net
References: <20030128151219.A953@humilis> <20030129001948.5DAF52C07D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129001948.5DAF52C07D@lists.samba.org>
User-Agent: Mutt/1.3.19i
X-Uptime: 12:08:18 up 10 min, 14 users,  load average: 0.47, 0.39, 0.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote (ao):
> In message <20030128151219.A953@humilis> you write:
> > Just booted my fresh compiled 2.5.59 (patched with reiser4 and kexec),
> > and did a 'modprobe lp'. It segfaulted. lsmod hangs.
> 
> Yep. This is due to a small bug in Kai's vmlinux.lds.h cleanup:

It does, tnx a lot :-)

(and sorry, a quick grep through my mail archives didn't catch the
thread, but after someone kindly mailed me the patch, I saw it was a
know issue).
