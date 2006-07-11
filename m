Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWGKKnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWGKKnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWGKKnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:43:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44726 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750996AbWGKKnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:43:19 -0400
Subject: Re: system 'date apis' in linux kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: chinmaya@innomedia.soft.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <44B3805C.9000608@innomedia.soft.net>
References: <44B3805C.9000608@innomedia.soft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 12:01:16 +0100
Message-Id: <1152615677.18028.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-07-11 am 16:11 +0530, ysgrifennodd Chinmaya Mishra:
> Hi. . . .
> 
> In the Linux kernel is there any apis are available
> which takes an unsigned long as an argument and
> return the date in string format. Just like ctime() in
> user space.

No, and thats an extremely complex process so best kept outside of the
kernel.

In particular the kernel has no idea about
- Summer time shifting
- Leap second rules for different timezones
- Locales

