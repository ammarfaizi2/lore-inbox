Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317996AbSGWIWA>; Tue, 23 Jul 2002 04:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317999AbSGWIWA>; Tue, 23 Jul 2002 04:22:00 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.131]:62677 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317996AbSGWIV7>; Tue, 23 Jul 2002 04:21:59 -0400
Date: Tue, 23 Jul 2002 02:25:04 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Lim <Daniel.Lim@dpws.nsw.gov.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mkinitrd problem
In-Reply-To: <sd3d92e4.031@out-gwia.dpws.nsw.gov.au>
Message-ID: <Pine.LNX.4.44.0207230208340.3241-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 23 Jul 2002, Daniel Lim wrote:
> /lib/modules/2.4.2-2/kernel/drivers/block/loop.o: unresolved symbol
> do_generic_file_read_R63b9dc6b

This is you're trying to use the correct module, but it's from the wrong 
kernel version. BTW, yes, you might try losetup -d /dev/loopx (or even 
better, when no loop devices are mounted,

for d in /dev/loop*; do
	losetup -d $d
done)

BAW, what's your kernel (uname -r)?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------


