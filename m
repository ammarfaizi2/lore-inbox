Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315553AbSEVOy3>; Wed, 22 May 2002 10:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315558AbSEVOy2>; Wed, 22 May 2002 10:54:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14840 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315553AbSEVOy0>;
	Wed, 22 May 2002 10:54:26 -0400
Date: Wed, 22 May 2002 10:54:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        "David S. Miller" <davem@redhat.com>, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AXfM-0001xc-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0205221053330.2737-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Alan Cox wrote:

> > The Xfree86 people are actually sane and hold up the BSD tradition.
> > They don't even use /proc/bus and killed early /proc/agpgart usage!
> > Quite the reverse is true.
> 
> XFree86 uses /proc/cpuinfo, /proc/bus/pci, /proc/mtrr, /proc/fb, /proc/dri
> and even such goodies as /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes

... and while we are at flamewar-mongering, none of these files have any
business being in procfs.

