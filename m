Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261466AbTC0Wop>; Thu, 27 Mar 2003 17:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbTC0Wop>; Thu, 27 Mar 2003 17:44:45 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:58126 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261466AbTC0Woo>; Thu, 27 Mar 2003 17:44:44 -0500
Date: Thu, 27 Mar 2003 23:55:55 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <UTC200303272237.h2RMbRE25133.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0303272346280.12110-100000@serv>
References: <UTC200303272237.h2RMbRE25133.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Mar 2003 Andries.Brouwer@cwi.nl wrote:

> But, as I answered you several times already,
> right now my topic is dev_t, not devices or partitions.
> Just the number.

Well, what can I do with that number? Your patches must provide some sort 
of benefit when we have that number. I'm currently trying to find out, 
what happens after we have this number, so I would be really grateful, if 
you would answer my questions:

How are these disks registered and how will the dev_t number look like?
How will the user know about these numbers?
Who creates these device entries (user or daemon)?
SCSI has multiple majors, disks 0-15 are at major 8, disks 16-31 are at
65, ...., disks 112-127 are at major 71. Will this stay the same? Where
are the disk 128-xxx?
Can I have now more than 15 partitions?

bye, Roman

