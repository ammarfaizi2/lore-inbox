Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261589AbSJAMKo>; Tue, 1 Oct 2002 08:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbSJAMKo>; Tue, 1 Oct 2002 08:10:44 -0400
Received: from mail.internet-factory.de ([62.134.147.34]:38558 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S261589AbSJAMKn>; Tue, 1 Oct 2002 08:10:43 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <holger@lubitz.org>
Newsgroups: lists.linux.kernel
Subject: Re: PIIX4 problem
Date: Tue, 01 Oct 2002 14:16:10 +0200
Organization: Internet Factory AG
Message-ID: <3D99920A.5070905@lubitz.org>
References: <3D998F27.2090403@lubitz.org>
NNTP-Posting-Host: gatekeeper.webserv-it.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1033474569 25541 62.134.144.10 (1 Oct 2002 12:16:09 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 1 Oct 2002 12:16:09 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Lubitz wrote:

sorry, first dmesg output was from a boot with dma disabled in the bios.
drives are set to mdma2 (disk) and mdma0 (cd) in this case. with udma 
enabled in the bios the output is

hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=4866/255/63, UDMA(33)
hdb: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)

and the non working output had this as a copy and paste error. in fact, 
the kernel with piix support _always_ detects the disk as UDMA(33) 
regardless of what I try to disable DMA (bootparameters, bios) and then 
the errors follow.

Holger

