Return-Path: <linux-kernel-owner+w=401wt.eu-S932248AbXAQOK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbXAQOK3 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 09:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbXAQOK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 09:10:29 -0500
Received: from mail.syneticon.net ([213.239.212.131]:35891 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248AbXAQOK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 09:10:28 -0500
Message-ID: <45AE2E25.50309@wpkg.org>
Date: Wed, 17 Jan 2007 15:09:41 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061110 Mandriva/1.5.0.8-1mdv2007.1 (2007.1) Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
References: <45AE1D65.4010804@wpkg.org> <Pine.LNX.4.61.0701171435060.18562@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0701171435060.18562@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> The device is pretty small and has no keyboard, video card etc., so if it ever
>> happens to break (can be a disk failure, but also operator who messed with
>> startup scripts), it has to be opened (warranty!).
>>
>> These all unpleasant tasks could be avoided if it was possible to have a
>> "fallback" device. For example, consider this hypothetical command line:
>>
>> root=/dev/sdb1,/dev/sda1
> 
> You should use initramfs to achieve that.

All right.
I see that initramfs is attached to the kernel itself.

So it leaves me only a question: will I fit all tools into 300 kB 
(considering I'll use uClibc and busybox)?


-- 
Tomasz Chmielewski
http://wpkg.org
