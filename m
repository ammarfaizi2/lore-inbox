Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316253AbSEWH2B>; Thu, 23 May 2002 03:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316260AbSEWH2A>; Thu, 23 May 2002 03:28:00 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:5042 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316253AbSEWH17>; Thu, 23 May 2002 03:27:59 -0400
Date: Thu, 23 May 2002 17:30:33 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: alan@lxorguk.ukuu.org.uk, dalecki@evision-ventures.com, davem@redhat.com,
        paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-Id: <20020523173033.6635611a.rusty@rustcorp.com.au>
In-Reply-To: <Pine.GSO.4.21.0205221053330.2737-100000@weyl.math.psu.edu>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2002 10:54:25 -0400 (EDT)
Alexander Viro <viro@math.psu.edu> wrote:
> On Wed, 22 May 2002, Alan Cox wrote:
> > XFree86 uses /proc/cpuinfo, /proc/bus/pci, /proc/mtrr, /proc/fb, /proc/dri
> > and even such goodies as /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes
> 
> ... and while we are at flamewar-mongering, none of these files have any
> business being in procfs.

Let it never be said that you lack courage 8)

Let's sort this out at the kernel summit:
 dev vs. driverfs. vs proc vs sysctl vs boot params vs. module params vs netlink

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
