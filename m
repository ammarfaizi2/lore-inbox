Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316600AbSE0NKl>; Mon, 27 May 2002 09:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316611AbSE0NKk>; Mon, 27 May 2002 09:10:40 -0400
Received: from scispor.dolphinics.no ([193.71.152.117]:37642 "EHLO
	scispor.dolphinics.no") by vger.kernel.org with ESMTP
	id <S316600AbSE0NKj>; Mon, 27 May 2002 09:10:39 -0400
Message-Id: <200205271306.g4RD6Bi11479@scispor.dolphinics.no>
From: "Simen Timian Thoresen" <simentt@dolphinics.no>
To: me@vger.org
Date: Mon, 27 May 2002 15:07:48 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: /dev/hd[ijkl] only using udma (not udma 100)
CC: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205271513080.7794-100000@kenny.worldonline.se>
X-mailer: Pegasus Mail for Win32 (v3.12b)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> Ive got a machine running debian test dist and 2.4.18. The machine has two
> promise ata100 tx2 controller cards. My question is why does the devices
> hde to hdh use udma100 but devices hdi to hdl only use udma. Note on this
> is that the devices hdi to hdl did i have to make myself (dont know if
> there is some other configure possibility). All drives are the same model.

I'm basically observing the same thing - 5 drives connected alone on their own 
ata100 channels (1 on a Via southbridge, 4 on HPT370 channels).


I'm seing speeds 33, 44, 66 and 69 as when examining /proc/ide/hdx/settings. 
There are 2 differing types of drives, but all are ATA100 capable.
 
This is also with 2.4.18, originally slackware 7.1

-Simen
--
Simen Thoresen
http://www.dolphinics.no
