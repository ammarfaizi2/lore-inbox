Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313707AbSDZITc>; Fri, 26 Apr 2002 04:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSDZITb>; Fri, 26 Apr 2002 04:19:31 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:12814 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S313707AbSDZITb>; Fri, 26 Apr 2002 04:19:31 -0400
Message-ID: <3CC90DC6.7030909@loewe-komp.de>
Date: Fri, 26 Apr 2002 10:20:22 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Michael De Nil <linux@aerythmic.be>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: USB Mass Storage -> Asus Stick
In-Reply-To: <Pine.LNX.4.44.0204252135440.16629-100000@LiSa>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael De Nil wrote:
> Heyz
> 
> I have an Asus USB Mass Storage Stick here, but when connecting it to my
> laptop running GNU/Linux 2.4.17, my system freezes... (It takes a couple
> of seconds between connection & freez)
> 
> I don't get any oops or something like that, ...
> 

It seems there are deadlock situations in usb-storage and the filesystem.
I get lockups on SMP boxes, hanging insmod usb-storage on UP with
Datafab (special transport) but also lockups with Transcend/ScanLogic.

Until now, I don't have a clue

