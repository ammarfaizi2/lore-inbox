Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282118AbRK1KaF>; Wed, 28 Nov 2001 05:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282125AbRK1KaA>; Wed, 28 Nov 2001 05:30:00 -0500
Received: from [195.63.194.11] ([195.63.194.11]:56325 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S282118AbRK1K3v>; Wed, 28 Nov 2001 05:29:51 -0500
Message-ID: <3C04BA44.73791F37@evision-ventures.com>
Date: Wed, 28 Nov 2001 11:19:48 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 elvtune: ioctl get: Inappropriate ioctl for device
In-Reply-To: <20011127234843.A6398@earthlink.net>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
> 
> This may be a kernel in transition thing, or perhaps
> a util-linux has to change.
> 
> In 2.5.1-pre2:
> 
> /usr/src# elvtune /dev/hda
> ioctl get: Inappropriate ioctl for device
> 
> /usr/src# nm linux-2.5.1-pre1/vmlinux|grep elv.*ioctl
> c0187400 T blkelvget_ioctl
> c01874b0 T blkelvset_ioctl


THis program is obsolete on 2.5.1-pre2. The elevator handling changed
much.
