Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317976AbSGWHLh>; Tue, 23 Jul 2002 03:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317977AbSGWHLh>; Tue, 23 Jul 2002 03:11:37 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.130]:19676 "EHLO
	moutvdomng0.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317976AbSGWHLg>; Tue, 23 Jul 2002 03:11:36 -0400
Date: Tue, 23 Jul 2002 01:14:40 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Lim <Daniel.Lim@dpws.nsw.gov.au>
cc: thunder@ngforever.de, <linux-kernel@vger.kernel.org>
Subject: Re: mkinitrd problem
In-Reply-To: <sd3d8c36.078@out-gwia.dpws.nsw.gov.au>
Message-ID: <Pine.LNX.4.44.0207230111410.3241-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 23 Jul 2002, Daniel Lim wrote:
> brw-rw----    1 root     disk       7,   0 Jul 23 16:06 /dev/loop0

So no devfs. Is the loop module loaded? Do a cat /dev/loop15 to see, but 
make sure that there is no mounted filesystem there. Please don't send the 
result in any case. If you get "No such file", you'll need to modprobe 
loop.

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

