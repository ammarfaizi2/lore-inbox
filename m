Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318873AbSHEUQR>; Mon, 5 Aug 2002 16:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318872AbSHEUQP>; Mon, 5 Aug 2002 16:16:15 -0400
Received: from smtp01.web.de ([194.45.170.210]:23069 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S318875AbSHEUPj>;
	Mon, 5 Aug 2002 16:15:39 -0400
Date: Mon, 5 Aug 2002 22:16:52 +0200
From: Lars Ellenberg <l.g.e@web.de>
To: linux-kernel@vger.kernel.org
Subject: stacked bdev driver, howto? locking of lower level block device
Message-ID: <20020805221652.A4250@johann>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, I'm new on this list.

I do some happy hacking with drbd, which is "distributed replicated
block device", a stacked block device driver by Phillipp Reisner,
aiming towards network raid, GFS, this stuff.

I'd like to implement some kind of locking of the lower level
block device, so nobody can mount it/modify it underneath the drbd
driver.

I know drivers/md/md.c does this somehow. I tried to understand
and adapt, but it does not work.

Hopefully my questions are trivial to some of you. Please put me
on the right track.

- How does block device locking work?
- In which mode do I have to open it?
- Which flags have to be set?
- What else am I missing?

TIA
	Lars-Gunnar
