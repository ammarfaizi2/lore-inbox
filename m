Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSHAQvo>; Thu, 1 Aug 2002 12:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSHAQvo>; Thu, 1 Aug 2002 12:51:44 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:12048 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S315746AbSHAQvn>;
	Thu, 1 Aug 2002 12:51:43 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Marcin Dalecki <dalecki@evision.ag>
Date: Thu, 1 Aug 2002 18:54:27 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] 2.5.29 IDE 110
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <C917933AE2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Aug 02 at 2:40, Marcin Dalecki wrote:
> 
> - Eliminate support for "sector remapping". loop devices can handle
>     stuff like that. All the custom DOS high system memmory loaded
>     BIOS workaround tricks are obsolete right now. If anywhere it should
>     be the FAT filesystem code which should be clever enough to deal with
>     it by adjusting it's read/write methods.

Hi Marcin,
  I'm using this on one system here - it has BIOS without LBA32, and
without support for >30GB disks, but I needed to put large disk with
already existing system to it, and using some disk manager was only
choice (EZDrive, using 0_to_1 remap)... I know that 0_to_1 remap
is broken for nr_sectors > 1, but it is hard to use loop device if
system does not come up without boot manager at all.
                                    Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
