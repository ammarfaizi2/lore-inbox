Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUF3GQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUF3GQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 02:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266571AbUF3GQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 02:16:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52111 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266569AbUF3GQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 02:16:46 -0400
Message-ID: <40E25AC1.6030302@pobox.com>
Date: Wed, 30 Jun 2004 02:16:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: George Georgalis <george@galis.org>
CC: Sebastian Slota <SSlota@gmx.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
References: <20040625213433.GB6502@trot.local> <29181.1088498805@www29.gmx.net> <20040630044352.GB8841@trot.local>
In-Reply-To: <20040630044352.GB8841@trot.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Georgalis wrote:
> I was able to dd ~140 GB with SATA_SIL today, on a stock bk kernel, till
> I ran out of disk, no errors. which was a pleasant unexpected surprise.
> 
> but when I checked "Timing buffered disk reads" it was around 25 MB/sec
> not the ~52 MB/sec I saw before with the oops. The odd thing was this
> disk was not in the blacklist so I don't know why it was running slower.


Try mounting a filesystem, unmounting it, and then doing the timing.

	Jeff


