Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281502AbRKUAJa>; Tue, 20 Nov 2001 19:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281499AbRKUAJV>; Tue, 20 Nov 2001 19:09:21 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:51727 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S281502AbRKUAJL>;
	Tue, 20 Nov 2001 19:09:11 -0500
Date: Wed, 21 Nov 2001 01:08:53 +0100
From: Werner Almesberger <wa@almesberger.net>
To: Rajeev Bector <rbector@andiamo.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kexec/LOBOS
Message-ID: <20011121010853.C7381@almesberger.net>
In-Reply-To: <GIEMIEJKPLDGHDJKJELAOELODBAA.rbector@andiamo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GIEMIEJKPLDGHDJKJELAOELODBAA.rbector@andiamo.com>; from rbector@andiamo.com on Tue, Nov 20, 2001 at 10:56:28AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajeev Bector wrote:
> Can anybody point me to the latest patches for
> this stufff (on 2.4.2 or later kernels ?). Any
> pointers which have documentation etc
> on this would be much appreciated ?

For bootimg, which does quite similar things, you may want to try
the patches by Mission Critical Linux, which include bootimg
http://oss.mclx.com/downloads/patches/
(up to 2.4.7, ia32 only)

You also need their version of bootimg(8) in mcore-user,
http://oss.mclx.com/projects/mcore/download.php

There is documentation on http://bootimg.sourceforge.net/

bootimg differs from kexec in that it tries to handle as much
policy as possible in user space, keeping the kernel part
comparably small.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Lausanne, CH                    wa@almesberger.net /
/_http://icawww.epfl.ch/almesberger/_____________________________________/
