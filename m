Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSIARXM>; Sun, 1 Sep 2002 13:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSIARXL>; Sun, 1 Sep 2002 13:23:11 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:40660 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317282AbSIARXL> convert rfc822-to-8bit; Sun, 1 Sep 2002 13:23:11 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Oliver Neukum <oliver@neukum.name>
To: linux-kernel@vger.kernel.org
Subject: question on spinlocks
Date: Sun, 1 Sep 2002 19:27:53 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209011927.53853.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is the following sequence legal ?

spin_lock_irqsave(...);
...
spin_unlock(...);
schedule();
spin_lock(...);
...
spin_unlock_irqrestore(...);

	TIA
		Oliver

