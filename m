Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbTC0WBI>; Thu, 27 Mar 2003 17:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbTC0WBI>; Thu, 27 Mar 2003 17:01:08 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:50184 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261404AbTC0WBI>; Thu, 27 Mar 2003 17:01:08 -0500
Date: Thu, 27 Mar 2003 23:12:16 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0303272245490.5042-100000@serv>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Mar 2003 Andries.Brouwer@cwi.nl wrote:

You must have overlooked some of my questions:

How are these disks registered and how will the dev_t number look like?
How will the user know about these numbers?
Who creates these device entries (user or daemon)?

> > How is backward compatibility done, so that I can still boot a 2.4 kernel?
> 
> Old device numbers remain valid, so all changes are completely
> transparent.

SCSI has multiple majors, disks 0-15 are at major 8, disks 16-31 are at 
65, ...., disks 112-127 are at major 71. Will this stay the same? Where 
are the disk 128-xxx?
Can I have now more than 15 partitions?

bye, Roman

