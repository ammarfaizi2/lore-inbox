Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318464AbSGaTPf>; Wed, 31 Jul 2002 15:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318466AbSGaTPf>; Wed, 31 Jul 2002 15:15:35 -0400
Received: from cheetah.monarch.net ([24.244.0.4]:6415 "HELO
	cheetah.monarch.net") by vger.kernel.org with SMTP
	id <S318464AbSGaTPe>; Wed, 31 Jul 2002 15:15:34 -0400
Date: Wed, 31 Jul 2002 13:16:20 -0600
From: "Peter J. Braam" <braam@clusterfs.com>
To: linux-kernel@vger.kernel.org
Subject: BIG files & file systems
Message-ID: <20020731131620.M15238@lustre.cfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I've just been told that some "limitations" of the following kind will
remain:
  page index = unsigned long
  ino_t      = unsigned long

Lustre has definitely been asked to support much larger files than
16TB.  Also file systems with a trillion files have been requested by
one of our supporters (you don't want to know who, besides I've no
idea how many bits go in a trillion, but it's more than 32).

I understand why people don't want to sprinkle the kernel with u64's,
and arguably we can wait a year or two and use 64 bit architectures,
so I'm probably not going to kick up a fuss about it.

However, I thought I'd let you know that there are organizations that
_really_ want to have such big files and file systems and get quite
dismayed about "small integers".  And we will fail to deliver on a
requirement to write a 50TB file because of this.

My first Linux machine was a 25MHz i386 with a 40MB disk....

- Peter -
