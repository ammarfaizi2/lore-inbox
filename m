Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317965AbSGWGbZ>; Tue, 23 Jul 2002 02:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317972AbSGWGbY>; Tue, 23 Jul 2002 02:31:24 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.131]:20725 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317965AbSGWGbY>; Tue, 23 Jul 2002 02:31:24 -0400
Date: Tue, 23 Jul 2002 00:34:28 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Lim <Daniel.Lim@dpws.nsw.gov.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: mkinitrd problem
In-Reply-To: <sd3d8473.096@out-gwia.dpws.nsw.gov.au>
Message-ID: <Pine.LNX.4.44.0207230033280.3241-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 23 Jul 2002, Daniel Lim wrote:
> # mkinitrd /boot/initrd-2.4.9-34.img 2.4.9-34
> All of your loopback devices are in use!

Yes, if all your loopback devices are in use, you'll have to umount some. 
cat /proc/mounts, and there umount some of the filesystems with the loop 
option.

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

