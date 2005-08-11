Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVHKR3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVHKR3p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVHKR3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:29:44 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:18367 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932265AbVHKR3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:29:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=Hfdc3b9BtzrM3eNk556T/Rsqk07SCFMTm2qxlRbLbTkrfmXm9THeVHmo8RqDzRAjrAC8dLD8mZ8YVubP90RynYcLFtpUHyT4F344E/fE5z1aghy41PSalU6Y5QTfSqXewNn20+WIV+LZ1nQaJJ1IMM0uFujfexRTRHKVprKTSfE=
Message-ID: <42FB8AFD.1080300@gmail.com>
Date: Thu, 11 Aug 2005 19:29:33 +0200
From: Hetfield <hetfield666@gmail.com>
Reply-To: hetfield666@gmail.com
Organization: hetfield666@gmail.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050810)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>,
       "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6-git3 undefined reference on _mntput
References: <4AnDw-3uy-7@gated-at.bofh.it> <4AnNc-3QB-39@gated-at.bofh.it>
In-Reply-To: <4AnNc-3QB-39@gated-at.bofh.it>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby ha scritto:
> Hetfield napsal(a):
> 
>> grep _mntput *
>> namei.c:        _mntput(nd->mnt);
>> namespace.c:void __mntput(struct vfsmount *mnt)
>> namespace.c:EXPORT_SYMBOL(__mntput);
>>
>>
>>  CC      fs/namei.o
>> fs/namei.c: In function `path_release_on_umount':
>> fs/namei.c:317: warning: implicit declaration of function `_mntput'
>>
>>
>> ....
>>
>>   LD      .tmp_vmlinux1
>> fs/built-in.o: In function `path_release_on_umount':
>> : undefined reference to `_mntput'
>> make: *** [.tmp_vmlinux1] Error 1
>>
>>
>> seems an underscore is missing.
> 
> 
> It seems, that there is one extra.
> -

oops sorry i got a wrong merge from gentoo sources.

my fault, discard this.

