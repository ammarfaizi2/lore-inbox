Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSFLUpL>; Wed, 12 Jun 2002 16:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSFLUpK>; Wed, 12 Jun 2002 16:45:10 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:64754 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S314080AbSFLUpJ>; Wed, 12 Jun 2002 16:45:09 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15623.44235.134423.210640@wombat.chubb.wattle.id.au> 
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH, TRIVIAL] Fix argument of BLKGETSIZE64 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jun 2002 21:45:04 +0100
Message-ID: <29395.1023914704@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


peter@chubb.wattle.id.au said:
>  The header in question *defines* the kernel to userspace interface.
> As such it is a kernel issue.  Any interface exposed to userspace must
> use types that are common to userspace and the kernel.  u64 is kernel
> only, therefore has no business being used in an ioctl declaration. 

Consider it documentation. Implement it. Don't include it.

--
dwmw2


