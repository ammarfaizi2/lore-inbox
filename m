Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283602AbRLDXo4>; Tue, 4 Dec 2001 18:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283588AbRLDXor>; Tue, 4 Dec 2001 18:44:47 -0500
Received: from yuha.menta.net ([212.78.128.42]:42747 "EHLO yuha.menta.net")
	by vger.kernel.org with ESMTP id <S283597AbRLDXoh>;
	Tue, 4 Dec 2001 18:44:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ivanovich <ivanovich@menta.net>
To: junio@siamese.dhis.twinsun.com, erik.tews@gmx.net (Erik Tews)
Subject: Re: Strange messages with 2.4.16
Date: Wed, 5 Dec 2001 00:44:15 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011203233612.J11967@no-maam.dyndns.org> <7vlmgjcy7u.fsf@siamese.dhis.twinsun.com>
In-Reply-To: <7vlmgjcy7u.fsf@siamese.dhis.twinsun.com>
MIME-Version: 1.0
Message-Id: <01120500441500.01169@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A Dimarts 04 Desembre 2001 07:10, junio@siamese.dhis.twinsun.com va escriure:
> >>>>> "Erik" == Erik Tews <erik.tews@gmx.net> writes:
>
> Erik> invalidate: busy buffer
> Erik> ... What do they want to
> Erik> tell me? Has anybody else seen this messages?
>
> I see them during shutdown (or reboot); a quick grep shows that
> they are coming from fs/buffer.c: invalidate_bdev().  My kernel
> is with RAID-1, and without lvm.

i get it _sometimes_ after a hdparm -t /dev/md0 which is a software RAID-0 
stripe with 2 IDE hd. running 2.4.15-pre8

but no idea what it means.... 

:-?
