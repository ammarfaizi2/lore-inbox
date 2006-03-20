Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWCTTZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWCTTZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWCTTZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:25:36 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:53141 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964886AbWCTTZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:25:35 -0500
Date: Mon, 20 Mar 2006 20:25:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Garzik <jeff@garzik.org>
cc: joe.korty@ccur.com, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16
In-Reply-To: <441EFCB0.6020007@garzik.org>
Message-ID: <Pine.LNX.4.61.0603202022590.3457@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org>
 <20060320171905.GA4228@tsunami.ccur.com> <441EFCB0.6020007@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> strace should be using sanitized versions of the kernel headers, not directly
> including them verbatim...
>
Now, would not it be good for everyone if the in-kernel headers get
every bit of sanitation? Especially those who are stuck with outdated 
versions of sanitized headers (thinking of FC3 and FC4) often do the
magic symlinking (/usr/include/linux -> /usr/src/linux/include/linux).


Jan Engelhardt
-- 
