Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283651AbRLEBKG>; Tue, 4 Dec 2001 20:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283654AbRLEBJ4>; Tue, 4 Dec 2001 20:09:56 -0500
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:49647 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S283651AbRLEBJl>; Tue, 4 Dec 2001 20:09:41 -0500
From: junio@siamese.dhis.twinsun.com
To: Ivanovich <ivanovich@menta.net>
Cc: erik.tews@gmx.net (Erik Tews), linux-kernel@vger.kernel.org
Subject: Re: Strange messages with 2.4.16
In-Reply-To: <20011203233612.J11967@no-maam.dyndns.org>
	<7vlmgjcy7u.fsf@siamese.dhis.twinsun.com>
	<01120500441500.01169@localhost.localdomain>
	<Pine.LNX.4.10.10112041603270.4880-100000@ares.sot.com>
Date: 04 Dec 2001 17:09:32 -0800
In-Reply-To: <01120500441500.01169@localhost.localdomain>
Message-ID: <7v1yiamq0j.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "I" == Ivanovich  <ivanovich@menta.net> writes:

I> A Dimarts 04 Desembre 2001 07:10, junio@siamese.dhis.twinsun.com va escriure:
>> >>>>> "Erik" == Erik Tews <erik.tews@gmx.net> writes:
>> 
Erik> invalidate: busy buffer
Erik> ... What do they want to
Erik> tell me? Has anybody else seen this messages?
>> 
>> I see them during shutdown (or reboot); a quick grep shows that
>> they are coming from fs/buffer.c: invalidate_bdev().  My kernel
>> is with RAID-1, and without lvm.

I> i get it _sometimes_ after a hdparm -t /dev/md0 which is a software RAID-0 
I> stripe with 2 IDE hd. running 2.4.15-pre8

I> but no idea what it means.... 

Google search helps.  This was reported around 2.4.11 and Linus
says this:

<http://www.uwsg.iu.edu/hypermail/linux/kernel/0110.1/0726.html>

