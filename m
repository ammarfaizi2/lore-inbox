Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVFLHMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVFLHMa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 03:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVFLHMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 03:12:30 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:23052 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261903AbVFLHMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 03:12:17 -0400
Date: Sun, 12 Jun 2005 09:12:13 +0200
From: Willy Tarreau <willy@w.ods.org>
To: subbie subbie <subbie_subbie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: optional delay after partition detection at boot time
Message-ID: <20050612071213.GG28759@alpha.home.local>
References: <20050612065050.99998.qmail@web30704.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612065050.99998.qmail@web30704.mail.mud.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 11:50:50PM -0700, subbie subbie wrote:
> Hello,
> 
>  I'm sure some of you have come across this annoying
> issue, the kernel messages scroll way too fast for a
> human to be able to read them (let alone vgrep them).
> 
>  I'm proposing two features;
> 
>  1. a configurable (boot time, via kernel command
> line) delay between each and every print -- kind of
> overkill, but may be useful sometimes. 
>  
>  2. a configurable (boot time, via kernel command
> line) delay after partition detection, so that a
> humble system administrator would be able to actually
> find out which partition he should specify at boot
> time in order to boot his system.   This is especially
> annoying on newer SATA systems where sometimes disks
> are detected as SCSI and sometimes as standard ATA
> (depending on BIOS settings), I'm sure though that it
> could be useful in a number of other cases.

What's the problem with "cat /proc/partitions" or "dmesg" ?
You seem to want to slow down *every* boot just to identify
a partition you need to find *once*. This seems overkill.

willy

