Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262503AbTCIMZb>; Sun, 9 Mar 2003 07:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262504AbTCIMZb>; Sun, 9 Mar 2003 07:25:31 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:19609 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S262503AbTCIMZa>; Sun, 9 Mar 2003 07:25:30 -0500
Message-Id: <200303091235.h29CZfGi000914@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] obselete some atm_vcc members 
In-reply-to: Your message of "Sat, 08 Mar 2003 12:50:24 PST."
             <20030308.125024.44441125.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Sun, 09 Mar 2003 07:35:41 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030308.125024.44441125.davem@redhat.com>,"David S. Miller" writes:
>This stuff was all against a tree which still had the atm_dev
>semaphore instead of the new spinlock.  Therefore half of the patches
>rejected and I had to put these parts in by hand.

err... its the other way around? the spinlock was converted to
a semaphore since you shouldnt sleep while holding a spinlock.
if that patch never made it i could resend it.
