Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131672AbRDCMcK>; Tue, 3 Apr 2001 08:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131662AbRDCMbw>; Tue, 3 Apr 2001 08:31:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21765 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131654AbRDCM3l>; Tue, 3 Apr 2001 08:29:41 -0400
Subject: Re: a quest for a better scheduler
To: fabio@chromium.com (Fabio Riccardi)
Date: Tue, 3 Apr 2001 13:31:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AC93417.7B7814FC@chromium.com> from "Fabio Riccardi" at Apr 02, 2001 07:23:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kPy7-0007xx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any special reason why any of those patches didn't make it to
> the mainstream kernel code?

All of them are worse for the normal case. Also 1500 running apache's isnt
a remotely useful situation, you are thrashing the cache even if you are now
not thrashing the scheduler. Use an httpd designed for that situation. Then
you can also downgrade to a cheap pentium class box for the task ;)

