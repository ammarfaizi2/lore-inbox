Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130821AbRCFOGN>; Tue, 6 Mar 2001 09:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130794AbRCFOGD>; Tue, 6 Mar 2001 09:06:03 -0500
Received: from samar.sasken.com ([164.164.56.2]:43698 "EHLO samar.sasi.com")
	by vger.kernel.org with ESMTP id <S130824AbRCFOFt>;
	Tue, 6 Mar 2001 09:05:49 -0500
Date: Tue, 6 Mar 2001 19:35:40 +0530 (IST)
From: Manoj Sontakke <manojs@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: spinlock help
Message-ID: <Pine.GSO.4.30.0103061926390.13816-100000@suns3.sasi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Thankx in idvance for the help.

1. when spin_lock_irqsave() function is called the subsequent code is
executed untill spin_unloc_irqrestore()is called. is this right?
2. is this sequence valid?
	spin_lock_irqsave(a,b);
	spin_lock_irqsave(c,d);

Manoj

