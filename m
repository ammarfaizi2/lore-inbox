Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262070AbSJVDdv>; Mon, 21 Oct 2002 23:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262079AbSJVDdu>; Mon, 21 Oct 2002 23:33:50 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:39917 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S262070AbSJVDdt>; Mon, 21 Oct 2002 23:33:49 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Haizhi Xu <hxu02@ecs.syr.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-14smp sys_call_table not found by the LKM loader
Date: Tue, 22 Oct 2002 13:31:20 +1000
User-Agent: KMail/1.4.5
References: <1035256996.3db4c4a484a23@webmail.ecs.syr.edu>
In-Reply-To: <1035256996.3db4c4a484a23@webmail.ecs.syr.edu>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210221331.20778.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 22 Oct 2002 13:23, Haizhi Xu wrote:
> Is it true that I can NOT reference sys_call_table[] from a kernel loadable
> module in 2.4.18-14smp or higher version kernels? Then if I need to
> intercept system calls, how should I do it?
Yes it is true.
You should intercept system calls like everyone else - source code patch into 
mainline.

Brad
- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9tMaIW6pHgIdAuOMRAj/5AKC5Hh98df8uQswKyNzjPIYb5eS+GQCeI9TW
lSPs+qDuFUNQ09NzlGeVrSw=
=vF/t
-----END PGP SIGNATURE-----

