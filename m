Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVACBgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVACBgY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 20:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVACBgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 20:36:24 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:41466 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261375AbVACBgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 20:36:22 -0500
Message-ID: <41D8A18B.7090507@verizon.net>
Date: Sun, 02 Jan 2005 20:36:11 -0500
From: Puneet Vyas <puneet.vyas@verizon.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
References: <20050102193724.GA18136@elf.ucw.cz> <20050102201147.GB4183@stusta.de> <20050102203610.GD4183@stusta.de>
In-Reply-To: <20050102203610.GD4183@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [68.239.182.186] at Sun, 2 Jan 2005 19:36:21 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Sun, Jan 02, 2005 at 09:11:47PM +0100, Adrian Bunk wrote:
>  
>
>>On Sun, Jan 02, 2005 at 08:37:24PM +0100, Pavel Machek wrote:
>>
>>    
>>
>>>Well, umount -l can be handy, but it does not allow you to get your CD
>>>back from the drive.
>>>
>>>umount --kill that kills whoever is responsible for filesystem being
>>>busy would solve part of the problem (that can be done in userspace,
>>>today).
>>>...
>>>      
>>>
>>What's wrong with
>>
>>  fuser -k /mnt && umount /mnt
>>...
>>    
>>
>
>I meant
>
>  fuser -km /mnt && umount /mnt
>
>cu
>Adrian
>
>  
>
I'm as newbie as they get but the above command just made my system 
freeze hard and I could do nothing but reboot (use the power switch). I 
had nothing mounted there but have a directory
under /mnt where I occasionaly mount my samba share. (which was not 
mounted when I tried this) . So much for user friendlyness ... oh well ...

~puneet
