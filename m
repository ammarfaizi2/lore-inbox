Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVA0Hgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVA0Hgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 02:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVA0Hgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 02:36:39 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:10272 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262136AbVA0Hgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 02:36:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dZsgy6WWsEak/1zFClySsvtzRWU10zEwvqEEyGXoQcFkGo5EEVN5OjbM8BGI2lQ80erUxEXqzvt6UF8HxF9F4ABNDC25JDXboUJuQBxVEVPETlbYy8uoV3tyvGBLZL2vw1xI7J+82R8u6NqQNXukjTQnfBL44GaB2Fkf6EKglFk=
Message-ID: <41F8998E.7060903@gmail.com>
Date: Thu, 27 Jan 2005 15:34:38 +0800
From: Andy liu <liudeyan@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sudhir@digitallink.com.np
CC: linux-kernel@vger.kernel.org
Subject: Re: confguring grub to load new kernel
References: <18910-220051427616499@M2W055.mail2web.com>
In-Reply-To: <18910-220051427616499@M2W055.mail2web.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sudhir@digitallink.com.np wrote:

>Hi,
>
>I just compiled kernel 2.6.10 and now wondering how to make the grub to
>load the newkernel.
>
>The grub.conf file is configured as:
>
>#boot=/dev/hda
>default=1
>timeout=10
>splashimage=(hd0,5)/boot/grub/splash.xpm.gz
>title Red Hat Linux (2.4.20-8)
>        root (hd0,5)
>        kernel /boot/vmlinuz-2.4.20-8 ro root=LABEL=/
>        initrd /boot/initrd-2.4.20-8.img
>title DOS
>        rootnoverify (hd0,0)
>        chainloader +1
>                                                                            
>    
>How should I change the configuration?
>
>sudhir
>
>--------------------------------------------------------------------
>mail2web - Check your email from the web at
>http://mail2web.com/ .
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
by the way,have you update your module utility?
kernel module format has changed in linux 2.6,so do not forget to update 
insmod lsmod modprobe.......
