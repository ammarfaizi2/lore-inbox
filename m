Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132012AbRCVNWh>; Thu, 22 Mar 2001 08:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132013AbRCVNW2>; Thu, 22 Mar 2001 08:22:28 -0500
Received: from darkstar.internet-factory.de ([195.122.142.9]:28551 "EHLO
	darkstar.internet-factory.de") by vger.kernel.org with ESMTP
	id <S132012AbRCVNWM>; Thu, 22 Mar 2001 08:22:12 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: UDMA 100 / PIIX4 question
Date: Thu, 22 Mar 2001 14:21:29 +0100
Organization: Internet Factory AG
Message-ID: <3AB9FC59.92C97ACE@internet-factory.de>
In-Reply-To: <20010321095533Z131410-407+1932@vger.kernel.org> <Pine.LNX.4.10.10103211000370.29537-100000@master.linux-ide.org>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 985267289 10267 195.122.142.158 (22 Mar 2001 13:21:29 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 22 Mar 2001 13:21:29 GMT
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac20 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

> You may get a burst because of caching prefetch or predictive readahead,
> but that is artifical; however, in your case the root directory begins 25%
> in the drive.

But still it gives faster transfers than /dev/hda. The question is why.
I do not think that factor 2 can be explained by prefetch or readahead
alone.

> First you have the faster portion of the drive using a lame OS, so do not
> expect Linux to perform if you put it on the slowest portions of the
> device.

:-) But putting it at the beginning at least leaves the linux partitions
together.
Having the root fs in the outermost partition might give slightly faster
transfers, but slightly longer seeks to get there.

> [root@via DiskPerf-1.0.3]# ./DiskPerf /dev/hda

Is that an unreleased version? kernel.org still has 1.0.1.

Holger
