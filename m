Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280904AbRKCBB5>; Fri, 2 Nov 2001 20:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280906AbRKCBBk>; Fri, 2 Nov 2001 20:01:40 -0500
Received: from gk.cyberbills.com ([64.41.210.81]:8203 "EHLO gk.cyberbills.com")
	by vger.kernel.org with ESMTP id <S280904AbRKCBB1>;
	Fri, 2 Nov 2001 20:01:27 -0500
Date: Fri, 2 Nov 2001 17:01:15 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Ivan Passos <lists@cyclades.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Annoying msgs about hda
In-Reply-To: <Pine.LNX.4.30.0111021629480.742-100000@intra.cyclades.com>
Message-ID: <Pine.LNX.4.31ksi3.0111021658110.9736-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, Ivan Passos wrote:

>
> Hello,
>
> [*** Please CC your answer to me directly, as I'm currently not
> subscribed
> to lkml ***]
>
> I'm building a tiny Linux system of my own (no distro, although I'm
> using
> Debian as a "sample"), which boots from a CompactFlash and uncompresses
> a
> RAMDisk into RAM. The CompactFlash remains usually unmounted (except
> during boot, when I want to save the system's configuration, upgrade
> the
> RAMDIsk image, etc.). I'm using kernel 2.4.9.
>
> I've noticed that every time I mount, fsck, or do any other "low-level"
> access to the CompactFlash (which is seen as a HD, /dev/hda), I get the
> following msgs:
>
> # mount /flash/config
>  hda: hda1 hda2 hda3  <--+---- These msgs (yes, they always show up
> twice)
>  hda: hda1 hda2 hda3  <--+
> #
>
>
> If I place the _same_ CF in a Debian Potato system using the same
> kernel,
> I don't get these msgs when mounting the CF. I'm pretty sure these msgs
> come from the kernel (I believe from the check_partition() function on
> linux/fs/partitions/check.c), but it's really annoying to get these
> msgs
> every time I mount the device!!
>
> Is there a way to prevent this?!?! Or ... why doesn't it happen on a
> "regular" distro (like my Debian system)??
>
> TIA for any advice/comment/insight.

This is because "regular" distro is running klogd.

---
Sergey Kubushin				Sr. Unix Administrator
Metavante, Inc.				Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV 89014

