Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbTC0VsX>; Thu, 27 Mar 2003 16:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbTC0VsX>; Thu, 27 Mar 2003 16:48:23 -0500
Received: from borderworlds.dk ([62.79.110.124]:8977 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S261393AbTC0VsW>; Thu, 27 Mar 2003 16:48:22 -0500
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: / listed twice in /proc/mounts
References: <Pine.LNX.4.21.0303272110420.16348-100000@ppg_penguin>
From: Christian Laursen <xi@borderworlds.dk>
Date: 27 Mar 2003 22:59:22 +0100
In-Reply-To: <Pine.LNX.4.21.0303272110420.16348-100000@ppg_penguin>
Message-ID: <m3isu44gjp.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Moffat <ken@kenmoffat.uklinux.net> writes:

> On 27 Mar 2003, Christian Laursen wrote:
> 
> > The other day, I upgraded the components of a software package
> > that I maintain, including updating the kernel from 2.4.18 to
> > 2.4.20.
> > 
> > I noticed something strange: / is now listed twice in /proc/mounts
> > like this
> > 
> > rootfs / rootfs rw 0 0
> > /dev/root / ext2 rw 0 0
> > 
> > It confused one of my scripts, so I had to implement a quick workaround.
> > 
> > Is this a feature or a bug?
> > 
> 
>  Is your /etc/mtab a symlink to /proc/mounts ?  That is generally
> thought not to be a good idea.

No, I'm running in a minimal environment without all the normal stuff,
so there isn't even an /etc/mtab.

-- 
Best regards
    Christian Laursen
