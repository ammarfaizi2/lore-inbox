Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVA0HMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVA0HMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 02:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVA0HMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 02:12:43 -0500
Received: from comodo.gotadsl.co.uk ([62.3.237.187]:33429 "EHLO
	kylie.comodo.net") by vger.kernel.org with ESMTP id S262524AbVA0HLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 02:11:25 -0500
Message-ID: <41F8949E.1050308@comodo.com>
Date: Thu, 27 Jan 2005 12:43:34 +0530
From: Sabarinathan <sabarinathan@comodo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sudhir@digitallink.com.np
CC: linux-kernel@vger.kernel.org
Subject: Re: confguring grub to load new kernel
References: <18910-220051427616499@M2W055.mail2web.com>
In-Reply-To: <18910-220051427616499@M2W055.mail2web.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Comodo-ClamAV-Virus-Check-By: kylie.comodo.net - PASSED!
X-Comodo-ClamAV-Virus-Version: ClamAV 0.80/686/Thu Jan 27 01:14:26 2005
X-Comodo-F-Prot-Virus-Check-By: kylie.comodo.net - PASSED!
X-Comodo-F-Prot-Virus-Program: F-PROT ANTIVIRUS Program version: 4.5.3 Engine version: 3.16.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Put this entry in your grub.conf file

title Red Hat Linux  (2.6.10)
        root (hd0,5)
        kernel /boot/vmlinuz-2.6.10 ro root=LABEL=/ rhgb quiet
        initrd /boot/initrd-2.6.10.img

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


-- 
Regards
Sabarinathan.A 
Trustix Os Programmer
Comodo India - "Invent ² Secure"
Temple Towers, Chennai
Mobile: 98403 66039

Registered Linux User: #376656







