Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316774AbSGVLGz>; Mon, 22 Jul 2002 07:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316780AbSGVLGz>; Mon, 22 Jul 2002 07:06:55 -0400
Received: from moutvdomng0.kundenserver.de ([195.20.224.130]:28369 "EHLO
	moutvdomng0.schlund.de") by vger.kernel.org with ESMTP
	id <S316774AbSGVLGx>; Mon, 22 Jul 2002 07:06:53 -0400
Date: Mon, 22 Jul 2002 05:09:59 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Sami Louko <samppa@pleco.mikrolahti.fi>
cc: Thunder from the hill <thunder@ngforever.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: still troubles with an Alpha-kernel
In-Reply-To: <20020722110237.GA12719@pleco.mikrolahti.fi>
Message-ID: <Pine.LNX.4.44.0207220508070.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 22 Jul 2002, Sami Louko wrote:
> 	Jul 22 09:07:55 mikrolahti kernel: Error seeking in /dev/kmem
> 
> What may be wrong??!

Some of the /proc file mappings. Are the other files in /proc OK? One can 
always have a 4TiB+ file, you just have to trick the system in thinking 
the file is that big. Otherwise it's just a plain procfs bug.

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

