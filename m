Return-Path: <linux-kernel-owner+w=401wt.eu-S932180AbXAQN4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbXAQN4o (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 08:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbXAQN4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 08:56:43 -0500
Received: from mail.syneticon.net ([213.239.212.131]:35854 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932180AbXAQN4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 08:56:43 -0500
Message-ID: <45AE2AF3.5070706@wpkg.org>
Date: Wed, 17 Jan 2007 14:56:03 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061110 Mandriva/1.5.0.8-1mdv2007.1 (2007.1) Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
References: <45AE1D65.4010804@wpkg.org> <9e0cf0bf0701170537s4bb663a1j2d45b4013da81fbc@mail.gmail.com>
In-Reply-To: <9e0cf0bf0701170537s4bb663a1j2d45b4013da81fbc@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> On 1/17/07, Tomasz Chmielewski <mangoo@wpkg.org> wrote:
>> Does this make sense?
> 
> Why not add this logic into your initramfs?

Because the kernel itself is on a small flash partition (RedBoot 
executes the kernel from /dev/mtd1), which is only 1572864 bytes big.

So it leaves me only about 300 kB left (kernel is about 1.2 MB) for all 
tools needed to script such a logic, and it includes all the tools I 
would need.
Another obstacle would be to place the initramfs image on the same 
partition as the kernel (normally, I dd kernel to /dev/mtd1).

Or perhaps, I don't understand initramfs correctly.


-- 
Tomasz Chmielewski
http://wpkg.org






