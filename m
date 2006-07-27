Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWG0Uik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWG0Uik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWG0Uik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:38:40 -0400
Received: from terminus.zytor.com ([192.83.249.54]:35502 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750756AbWG0Uij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:38:39 -0400
Message-ID: <44C9244B.1020708@zytor.com>
Date: Thu, 27 Jul 2006 13:38:35 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: patch for Documentation/initrd.txt?
References: <200607272026.57695.a1426z@gawab.com> <44C90B6F.5070000@zytor.com> <200607272335.36819.a1426z@gawab.com>
In-Reply-To: <200607272335.36819.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> H. Peter Anvin wrote:
>> Al Boldi wrote:
>>> Thanks for your very useful docPatch!
>>>
>>> OT, but your docPatch made me think of another way to init the kernel;
>>> via tmpfs, i.e. initTmpFS.
>>>
>>> Can anybody see how that could be useful?
>> Useful, yes, but this has turned out to be fairly complex.
> 
> Sounds like somebody tried this before?
> 

Several people, yes.

>> tmpfs needs
>> a *LOT* more of the system to be fully operational than ramfs, and the
>> rootfs is initialized very early on, since one of its purposes is to
>> eliminate special cases.
> 
> So would it be possible to remap rootfs from ramfs to tmpfs, once tmpfs is 
> initialized, without actually doing another cpio?

That sounds nasty.

	-hpa
