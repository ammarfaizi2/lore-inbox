Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280314AbRKNH7u>; Wed, 14 Nov 2001 02:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280307AbRKNH7l>; Wed, 14 Nov 2001 02:59:41 -0500
Received: from NO-SPAM.it.helsinki.fi ([128.214.205.34]:35291 "EHLO
	no-spam.it.helsinki.fi") by vger.kernel.org with ESMTP
	id <S280318AbRKNH70>; Wed, 14 Nov 2001 02:59:26 -0500
Subject: Re: [OT] Odd partition overlapping problem
From: Robert Holmberg <robert.holmberg@helsinki.fi>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1005724114.405.0.camel@spinel>
In-Reply-To: <Pine.LNX.3.95.1011113095524.1544A-100000@chaos.analogic.com> 
	<1005691726.2007.0.camel@localhost>  <1005724114.405.0.camel@spinel>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 14 Nov 2001 10:02:59 -0500
Message-Id: <1005750180.1234.2.camel@localhost>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-14 at 02:48, Andrew Ebling wrote:
> Did you by any chance format/partition the disk using Linux Mandrake
> 7.1/7.2 at some point in the past?  I had a similar problem and
> eventually traced it back to a bug in the Mandrake installer which
> creates overlapping partitions.  I realised after running defrag in
> windows, which quite happily defragmented the first 200MB of my Linux
> partition!

Ouch. I used Mandrake 8.0... It seems my hda 6 os overlapping my hda4.
If I delete my extended partition, restart to windows and use dos fdisk
to create a new d:, there is the risk of this d: overwriting something
more important than my evolution install. I'm going to try this anyway.
I can always set up a swap *file* instead.

Partition table: 
Device 	  Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1       523   4200966    c  Win95 FAT32 (LBA)
/dev/hda2           524       525     16065   83  Linux
/dev/hda3           526      2647  17044965   83  Linux
/dev/hda4          2648      3736   8747392+   5  Extended
/dev/hda5          2648      2713    530113+  82  Linux swap
/dev/hda6          2714      3736   8217216    c  Win95 FAT32 (LBA)

Please cc to me, I'm not on the list.

