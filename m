Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbTLaDGL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 22:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266098AbTLaDGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 22:06:11 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:5076 "EHLO mail4.ewetel.de")
	by vger.kernel.org with ESMTP id S266097AbTLaDGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 22:06:09 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
In-Reply-To: <18Cz7-7Ep-7@gated-at.bofh.it>
References: <18Cz7-7Ep-7@gated-at.bofh.it>
Date: Wed, 31 Dec 2003 04:05:59 +0100
Message-Id: <E1AbWgJ-0000aT-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003 01:40:09 +0100, you wrote in linux.kernel:

>     2) udev does not care about the major/minor number schemes.  If the
>        kernel tomorrow switches to randomly assign major and minor numbers
>        to different devices, it would work just fine (this is exactly
>        what I am proposing to do in 2.7...)

Why? I want to keep my static device files in /dev. I don't even have
hotpluggable devices, and many months do pass before even one piece
of hardware gets changed (in which case I know what I have to do).
I don't want to eat any overhead or run any daemons or hotplug agents.

What benefit would there be in "random" numbers? More compressed number
space by giving out numbers sequentially? Or less having to work with
the numbers because they become just cookies and never need to be
inspected except in very small parts of the kernel?

-- 
Ciao,
Pascal
