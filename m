Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130311AbRBUL6x>; Wed, 21 Feb 2001 06:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130405AbRBUL6e>; Wed, 21 Feb 2001 06:58:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7434 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130311AbRBUL6Z>; Wed, 21 Feb 2001 06:58:25 -0500
Subject: Re: Linux 2.4.1-ac15
To: rusty@linuxcare.com.au (Rusty Russell)
Date: Wed, 21 Feb 2001 12:01:26 +0000 (GMT)
Cc: prumpf@mandrakesoft.com (Philipp Rumpf),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <E14VPXZ-0007HS-00@halfway> from "Rusty Russell" at Feb 21, 2001 02:02:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VXxY-0001wy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a while back, but I thought the solution Philipp and I came up
> with was to simply used a rw semaphore for this, which was taken (read
> only) on page fault if we have to scan the exception table.

We can take page faults in interrupt handlers in 2.4 so I had to use a 
spinlock, but that sounds the same

