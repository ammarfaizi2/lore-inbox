Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVHHPi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVHHPi2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVHHPi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:38:27 -0400
Received: from terminus.zytor.com ([209.128.68.124]:59303 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750945AbVHHPi1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:38:27 -0400
Message-ID: <42F77C55.9040501@zytor.com>
Date: Mon, 08 Aug 2005 08:37:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
CC: Sam Ravnborg <sam@ravnborg.org>, klibc@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: [klibc] Re: [PATCH - RFC] Move initramfs configuration to "General
 setup"
References: <20050808135936.GA9057@mars.ravnborg.org> <Pine.LNX.4.63.0508081610400.29195@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.63.0508081610400.29195@alpha.polcom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:
> 
>> From my recent experiments it looks like in order to be able to use 
> 
> initramfs not compiled into the kernel image but loaded from separate 
> file by GRUB or LILO one must also build initrd into the kernel.
> 
> Am I right? If so, could somebody split initramfs and initrd (not only 
> at configuration level but also at code level)? Shouldn't they be 
> separated (and possibly initrd removed after some time)? In the mean 
> time it should be documented in *config help.
> 

Actually, most of CONFIG_INITRD is about being able to pick up the 
second load datum, so it makes sense on the code level at least.

> Also somebody should add more documentation about initramfs (generating, 
> writing scripts, producing image, the right method for chroot / 
> pivot_root / ...). It took me whole week to find it out myself and I 
> still have some doubths...

Yes, that would be good.

	-hpa
