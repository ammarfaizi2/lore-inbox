Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSGMPQq>; Sat, 13 Jul 2002 11:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSGMPQp>; Sat, 13 Jul 2002 11:16:45 -0400
Received: from pD9E23254.dip.t-dialin.net ([217.226.50.84]:36736 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314551AbSGMPQo>; Sat, 13 Jul 2002 11:16:44 -0400
Date: Sat, 13 Jul 2002 09:19:20 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Further madness in fs/partitions/check.c?
In-Reply-To: <200207131449.g6DEnbk02977@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207130918160.3331-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 13 Jul 2002, James Bottomley wrote:
> This is transient code to save the device in the driver_data.  It is
> later picked back out at line 229.  It conforms to the old programmer
> principle that if you can always guarantee your data takes up less space
> than a pointer (on all archs), then you might as well just cast the data
> into the pointer instead of wasting a malloc for it.

However, it issues a warning.

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

