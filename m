Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSHMIgZ>; Tue, 13 Aug 2002 04:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSHMIgZ>; Tue, 13 Aug 2002 04:36:25 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:55444 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S313477AbSHMIgX>;
	Tue, 13 Aug 2002 04:36:23 -0400
Date: Tue, 13 Aug 2002 11:40:08 +0300 (EEST)
From: Meelis Roos <mroos@cs.ut.ee>
To: kuznet@ms2.inr.ac.ru
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux TCP problem while talking to hostme.bkbits.net ?
In-Reply-To: <200208121732.VAA18612@sex.inr.ac.ru>
Message-ID: <Pine.GSO.4.43.0208131137110.14316-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that checksum in tcpdump is OK.
> This smells really bad.
>
> I feel you have to hunt where exactly the segment is dropped
> and TCPInErrs is incremented.

Things got stranger. The symptoms started to appear on other connections
too (slashdot web for example). TCP bad packet count increased and no
success was made. I did a reboot with the same kernel (2.4.19+bk of some
state, 4. Aug probably) and it just started to work with the same kernel
image.

Now I will test and see if the symptoms appear again after some days.

-- 
Meelis Roos             e-mail: mroos@ut.ee
                        www:    http://www.cs.ut.ee/~mroos/

