Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262974AbRE1Fcu>; Mon, 28 May 2001 01:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262976AbRE1Fck>; Mon, 28 May 2001 01:32:40 -0400
Received: from femail15.sdc1.sfba.home.com ([24.0.95.142]:50146 "EHLO
	femail15.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S262974AbRE1Fcc>; Mon, 28 May 2001 01:32:32 -0400
Date: Mon, 28 May 2001 01:32:23 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac2
Message-ID: <20010528013223.A523@zero>
In-Reply-To: <20010528013342.A9840@lightning.swansea.linux.org.uk> <20010527233801.A643@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010527233801.A643@zero>; from tmv5@home.com on Sun, May 27, 2001 at 11:38:01PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

actually, it happens on ext2, also. it was fun trying to switch back to 2.2
after converting raid devs for 2.4 and trashing my emergency boot disk. i
was finally able to restore from tape by mounting -o sync. there was still
some minor corruption caught by fsck, though.

the new sym53c875 driver seems to have fixed the pci_map_sg() problem i was
having, but now it complains about scsi script errors. changing the TCQ
defaults from 32 to 8 fixes that. though, the corruption (even with TCQ max
8 and -o sync) may be related.

anyone else tried 2.4.5-ac2 on a miata or other alpha?

On Sun, May 27, 2001 at 11:38:01PM -0400, Tom Vier wrote:
> i haven't had any reiserfs crashes on my alpha, but restoring a backup of a
> debian installation to a reiserfs partition doesn't quite work. untarring a
> linux kernel tarball to the fs works, does work though. i get these kernel
> messages:

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
