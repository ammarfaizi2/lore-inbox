Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVBKQVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVBKQVc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 11:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVBKQVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 11:21:32 -0500
Received: from mail03.hansenet.de ([213.191.73.10]:31894 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S262269AbVBKQV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 11:21:27 -0500
Message-ID: <420CDB93.70506@web.de>
Date: Fri, 11 Feb 2005 17:21:39 +0100
From: Marcus Hartig <m.f.h@web.de>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to disable slow agpgart in kernel config?
References: <420C4B9A.6020900@web.de> <20050211062100.GB1782@redhat.com>
In-Reply-To: <20050211062100.GB1782@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> probably you have selected IOMMU, which is dependant on it.

Yes, thanks. Sorry my fault. I had it not deactivated, arggg.

> This surprises me, especially considering the in-kernel nvidia-agp driver
> was actually written by NVidia. Are there any agp error messages in
> your dmesg / X log ?

No warnings/errors in both logs. All clean. But switching/maximizing 
between tasks like firefox, thunderbird or a gnome-terminal is so slow, 
that you can see it how firefox/GTK+ theme is writing the GUI and the 
fonts slowly back. Minimizing is no more fun, like a fast slide-show. And 
that on a fast amd64 3200 with 1 GB RAM and a FX 5900XT. :(

With the nVidia own nv_agp it appears directly in all apps, very fast 
under GNOME 2.8.1. Why, I do not know. Also game (opengl) performance is 
faster with the nv_agp, that I haven't used the kernel agp for months, now.

Greetings,
Marcus
