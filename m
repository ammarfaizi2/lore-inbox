Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132004AbQKSCeG>; Sat, 18 Nov 2000 21:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132179AbQKSCd5>; Sat, 18 Nov 2000 21:33:57 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:14090 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S132004AbQKSCdt>;
	Sat, 18 Nov 2000 21:33:49 -0500
Date: Sun, 19 Nov 2000 03:03:45 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swap=<device> kernel commandline
Message-ID: <20001119030345.F23030@almesberger.net>
In-Reply-To: <20001118141524.A15214@nic.fr> <Pine.LNX.4.21.0011181804360.9267-100000@duckman.distro.conectiva> <20001118223455.G23033@almesberger.net> <m11yw86byt.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11yw86byt.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Nov 18, 2000 at 05:29:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> I have one that loads a second kernel over the network using dhcp 
> to configure it's interface and tftp to fetch the image and boots
> that is only 20kb uncompressed....

Neat ;-) My goal is actually not only size, but also to have a relatively
normal build environment, e.g. my example is with shared newlib, regular
ash, and - unfortunately rather wasteful - glibc's ld.so.

But a tftp loader in 20kB is rather good. Now the next challenge is the
same thing with NFS. Then we can finally kill nfsroot ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
