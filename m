Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbTAERNq>; Sun, 5 Jan 2003 12:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTAERNq>; Sun, 5 Jan 2003 12:13:46 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:41178 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264903AbTAERNp>; Sun, 5 Jan 2003 12:13:45 -0500
Date: Sun, 05 Jan 2003 09:27:51 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: ehci-hcd.o still a problem kernels > 2.4.20?
To: Frank Jacobberger <f1j1@xmission.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E186B17.8090506@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need to be using this patch if you have Intel hardware,
and users with VIA hardware will be significantly happier:

   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=104040598627391&w=2

It was also posted to linux-usb-users, and is in the queue
of fixes I hope will be merged into the next 2.4.21pre patch.
I got a fair amount of feedback from folk using this patch;
as expected, it's better all around.

- Dave



