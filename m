Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVAGQh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVAGQh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVAGQh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:37:27 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:7896 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261503AbVAGQhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:37:05 -0500
Message-Id: <200501071636.j07Gateu018841@localhost.localdomain>
To: Martin Mares <mj@ucw.cz>
cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 07 Jan 2005 17:29:02 +0100."
             <20050107162902.GA7097@ucw.cz> 
Date: Fri, 07 Jan 2005 11:36:55 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.197.185.179] at Fri, 7 Jan 2005 10:36:57 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Yes, but is there really some difference between people having to enable
>LSM and add a new LSM module, and people recompiling the kernel to include
>capabilities?

Well, one is configuration issue, the other involves hacking the
kernel headers before recompiling. Maybe you and I might not seem much
difference, but many people would. One of them says "the kernel gang
think this is OK to use if you want to", the other one says "err, you
can do this but don't call me if it goes wrong".

>Also, is somebody really shipping 2.4 kernels without capabilities?
>I'm unable to find any such config switch in 2.4.28 -- maybe it's because
>I'm almost sleeping now, but it doesn't seem to be there.

They are present but disabled by default. You have to hack the initial
values of CAP_INIT_EFF_SET and CAP_INIT_IHN_SET.

--p
