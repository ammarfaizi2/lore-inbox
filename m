Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRHLCkS>; Sat, 11 Aug 2001 22:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268928AbRHLCkH>; Sat, 11 Aug 2001 22:40:07 -0400
Received: from u-15-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.15]:30101
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S268926AbRHLCkA>; Sat, 11 Aug 2001 22:40:00 -0400
Date: Sun, 12 Aug 2001 04:38:41 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: "ext3-users@redhat.com" <ext3-users@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.6
Message-ID: <20010812043841.B8413@bacchus.dhis.org>
In-Reply-To: <3B75DE86.EEDFAFFB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B75DE86.EEDFAFFB@zip.com.au>; from akpm@zip.com.au on Sat, Aug 11, 2001 at 06:40:22PM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2001 at 06:40:22PM -0700, Andrew Morton wrote:

> - ext3 has for a long time had developer code which allows the target device
>   to be turned read-only at the disk device driver level a certain number
>   of jiffies after the fs was mounted.  This is to allow scripted testing
>   of crash recovery.  This facility has been extended to support two devices;
>   one for the filesystem and one for the external journal device.

Would this facility also be able to deal with parts of a device becoming
read-only unexpectedly?  Some of the disks I have in RAIDs have the
nice habit of disabling write access when overheating.  That's an
interesting failure scenario in a RAID system.

  Ralf
