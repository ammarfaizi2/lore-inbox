Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSHTWYt>; Tue, 20 Aug 2002 18:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSHTWYt>; Tue, 20 Aug 2002 18:24:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6410 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317462AbSHTWYs>;
	Tue, 20 Aug 2002 18:24:48 -0400
Message-ID: <3D62C2A3.4070701@mandrakesoft.com>
Date: Tue, 20 Aug 2002 18:28:51 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "Warner, Bill (IndSys, GEFanuc, VMIC)" <Bill.Warner@gefanuc.com>
Subject: Re: IDE-flash device and hard disk on same controller
References: <Pine.LNX.4.10.10208201452210.3867-100000@master.linux-ide.org> <3D62BC10.3060201@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Attached is the ATA core...

Just to give a little bit more information about the previously attached 
code, it is merely a module that does two things:  (a) demonstrates 
proper [and sometimes faster-than-current-linus] ATA bus probing, and 
(b) demonstrates generic registration and initialization of ATA devices 
and channels.  All other tasks can be left to "personality" (a.k.a. 
class) drivers, such as 'disk', 'cdrom', 'floppy', ... types.

	Jeff



