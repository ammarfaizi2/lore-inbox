Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132140AbRDNNbm>; Sat, 14 Apr 2001 09:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132142AbRDNNbc>; Sat, 14 Apr 2001 09:31:32 -0400
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:34320 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S132140AbRDNNbV>; Sat, 14 Apr 2001 09:31:21 -0400
Date: Sat, 14 Apr 2001 15:00:28 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MO-Drive under 2.4.3
Message-ID: <20010414150028.A456@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01041310475000.02120@majestix> <E14o3Jb-0002q9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
In-Reply-To: <E14o3Jb-0002q9-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Apr 13, 2001 at 02:08:41PM +0100
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 02:08:41PM +0100, Alan Cox wrote:
> > I have a problem using my MO-Drive under kernel 2.4.3. I have several disks 
> > formated with a VFAT filesystem. Under kernel 2.2.19 everything works fine. 
> > Under kernel 2.4.3 I cannot write anything to the disk without hanging the 
> > complete system so that I have to use the reset button. For disks with an 
> > ext2 filesystem it works okay.
> 
> This is a bug in the scsi layer. linux-scsi@vger.kernel.org, not that any of
> the scsi maintainers seem to care about it right now.

Err..., now I'm confused. Last time this issue popped up, it was my
understanding that it's generic_file_{read,write}'s limitation to filesystems
with logical_blksize >= hw_blksize that makes MOs fail with VFAT. Now, is
this all moot, or is the SCSI thing just an additional problem?

Regards,

Daniel.

-- 
	GNU/Linux Audio Mechanics - http://www.glame.de
	      Cutting Edge Office - http://www.c10a02.de
	      GPG Key ID 89BF7E2B - http://www.keyserver.net
