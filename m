Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310706AbSCQM3P>; Sun, 17 Mar 2002 07:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310728AbSCQM3G>; Sun, 17 Mar 2002 07:29:06 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:23266 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S310706AbSCQM2z>;
	Sun, 17 Mar 2002 07:28:55 -0500
Date: Sun, 17 Mar 2002 13:28:43 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>
Subject: Re: /dev/md0: Device or resource busy
In-Reply-To: <Pine.LNX.4.33.0203161937390.7016-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.44.0203171320300.21623-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002, dean gaudet wrote:
> ACK!  sorry.  it's not the kernel code, it's raidstop.  it seems to open
> /dev/md0 an extra time for what reason i'm not sure.  it even does it when
> you're referring to other md devices.  for example:

It does this for checking the md driver version. For some reason, the
close() was commented out. I alerted the Debian maintainer about this
a few days ago.

> fwiw dpkg tells me i've got raidtools 0.90.20010914-9

It's fixed in 0.90.20010914-11.

Eric

