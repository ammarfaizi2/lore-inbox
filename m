Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263014AbSJGMqX>; Mon, 7 Oct 2002 08:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263017AbSJGMqX>; Mon, 7 Oct 2002 08:46:23 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:62193 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S263014AbSJGMqW>;
	Mon, 7 Oct 2002 08:46:22 -0400
Date: Mon, 7 Oct 2002 14:52:00 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210071252.OAA17180@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: initrd breakage in 2.5.38-2.5.40
Cc: viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002 13:00:05 +0200, Mikael Pettersson wrote:
>I've been experiencing initrd-related problems since 2.5.38.
>It worked like a charm up to 2.5.37.
>
>The initrd itself works (mine allows users to select root
>partition, no modules involved), but some time later, the
>kernel hangs hard. (No message, NMI watchdog and SysRQ don't
>work.) I can trigger the hangs easily by generating a lot of
>FS activity, e.g. by unpacking a kernel tarball just after boot.
>
>When booting without an initrd image the kernel is rock solid.

Additional information: the problems occurs on every machine
I've tested, and it occurs even if I use a trivial initrd whose
/linuxrc just is "int main(void){return 0;}", so it's not caused
by mounting/pivot_root:ing from the initrd.

/Mikael
