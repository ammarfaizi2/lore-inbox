Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbTEOVd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 17:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbTEOVd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 17:33:57 -0400
Received: from fkn.j.pl ([80.48.48.38]:6822 "EHLO fkn.net.pl")
	by vger.kernel.org with ESMTP id S264253AbTEOVdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 17:33:55 -0400
Reply-To: <Marcin@MWiacek.com>
From: "Marcin Wiacek" <Marcin@MWiacek.com>
To: "'Lionel Bouton'" <Lionel.Bouton@inet6.fr>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [SiS IDE patch] various fixes
Date: Thu, 15 May 2003 23:43:56 +0200
Message-ID: <000601c31b2b$77b6acb0$ef0063d9@marcin>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0007_01C31B3C.3B3F7CB0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
In-Reply-To: <3EC3B7F1.4050105@inet6.fr>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C31B3C.3B3F7CB0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi,

> These errors are normal (the requested info is meaningless on CD/DVD 
> drives).
[...]
>  From the .config you sent, " CONFIG_IDEDMA_ONLYDISK is not set ", so 
> dma being disabled for your CD/DVD drives may be related to 
> them having 
> bugs in DMA mode, the kernel IDE subsystem disables DMA or higher dma 
> modes with peripherals it knows to be buggy. Please send the 
> output of 
> "hdparm -i /dev/<yourdrive>"
[....]
> IIRC this message is in fact harmless, do you have any other problem 
> with the harddrive ?

With all respect. I'm NOT newbie (also in Linux). 2.4.21 is first kernel
version, where I have problems with IDE subsystem (both on old and new
PC).

When I enabled both standard IDE and SiS IDE drivers, errors
("DriveReadySeekCompleteError" and similiar) don't allow system to
start.

When I use SIS IDE only, DMA is not enabled by default (for UDMA 33
devices - earlier in 2.4.20 and earlier IT WAS DONE).

Today I bough new IDE card  with Silicon Image and Silicon Image IDE
driver also shows errors with HDD (which is 100% OK). 

Please treat it seriously. I know, how to configure Linux kernel - I
make it from few years. In 2.4.21 there is REALLY something wrong.
Please do not say, that errors are normal - earlier they didn't exist
and weren't shown anywhere (also in hdparm). I'm here and can give all
required info for tracking bug. Please treat it seriously. When kernel
shows errors in some parameters configurations, doesn't allow to use
some combination of config parameters or when doesn't enable DMA, there
is something wrong.

In attachment config info from hdparm.

Pozdrowienia/Best Regards
-- 
Marcin Wiacek (www.mwiacek.com marcin@mwiacek.com)

------=_NextPart_000_0007_01C31B3C.3B3F7CB0
Content-Type: application/octet-stream;
	name="ID.ZIP"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="ID.ZIP"

UEsDBBQAAAAIAHW1ry4ZATdapgEAAHICAAABAAAAMWWRX2+bMBTF3/kU93GbqLDB0BTJlQgkSqSS
RMC27tHBZrVKcGUgaVb1u8/2tD/SHjj4np8P92J7ARfn4Imz1POgVFz0dJtH8QMiKPuyqtDtDfJh
fanEma4qss8IyXyohZas3ylaP+7qR7wL7xLsQa6GTn6nb7BhmteinWCnpnJdwobXl3scz8aDtXwV
HIqmuseoPI7w7kHFLvmmpjiJFlGAkyCJfGj0cy1/CIpss3b6vV7l+fE6iZES5MFy7rrm+iJoMbP+
oPSUs/ZJ+M53AXyHk+elDyV7Led+sh8yXUz9tzBTz/q/7sazfDRujAlKiA8Py4xexegWo2MLRPAi
tINs91XxjaohUF3nw3TY7unbSQ6pgf4lcDTFIXo3rCizX8zUvhat8z0wETiZwx9TgBepkBVsJbQS
WSHggUn/2XbiJ4acYqeh4Z//2TA7Pjs+O241ckrgk33FJpLxMxtawQ+l/b0UuBzZsTdX9CGM44/w
VctJuHOlYnDATKHlWUBrblvp0wiTSiFrssA8h+1NDA2OAEchLkCLsxylGgCbeUOIgEDseT8BUEsD
BBQAAAAIAHW1ry5URQVHhgEAAEACAAABAAAAMl2RT2+cMBDF7/4Uc+mlQgEbsk2RvBLLZrWRSjYF
2qpHFg+NtWCvjIFsonz3Gvov6uVp5v2ePSOb+AJH/1FgTAhkWmDLizJklNLEg92U48jDq+DGgwKN
rNp7zVfJPrj9zL4SSLVq5A/+AvvKiAJrC/faZrsM9qKY1vR6cB7s5BMK2Jb5mgbZsYdc2+IsSt2u
r67fwSuBvJrSfcGj4CPz6cpfhR6U5lTIZ+TBPLa2f+rbND1eLPY8ILAZmqa8nJEP6qT0pLzFWZKU
3Zw2HmTVUza0dr6Ah8z1/xq3+mD+H+qsGfc8oiz6EK48+LRJ+AX7pejfIgJ3h3z7nWvl66bxwD7c
HfhLJ1XMosCb/IXGlAWvjm2z5BdzvWewXnwC7gh07r37GOAsdTALnYXNEs4SAQF3+m+sE10VLEoX
ZY5/eRMYFj4s/P3wO5CIsVI1ioeMKw3fjLSYVvUjclTVsUXhRhg5ItTuM7XperA6BoGjrBGExh6U
tmDwrI2FEU0vtXKrUGAQQkTIT1BLAwQUAAAACAB1ta8uTU1WpnABAAAyAgAAAQAAADNNUV1vmzAU
ffevOI/bxAYmSaWheRKBVos0lohkk/ZI8KWzGuzIBtKs6n8f9r4qpKNzz4evhVksaYp/yDZjDJWR
dBI7ZTSRRfmtfFtvK+SHfLcJVpA4v0HC0zTC3aWmSdzyd37Yk1XN6YsRDIXRnboXT7hTjyRRU28m
ao4nQnmoP4hVdXSefeSJZ9roqrnXNKgWzwx1cyk+7UUSz1+Eg33Yq58kEr+gHf7y26I4XgdyImFY
j113uJ5J8MXi/SoKc8jdLB/WEarmsRpPg2/79Ku+uR7pdYZitC/2zJNPOH/453UuruQCcb9Fhs22
Lr8Lo2PTdRGG3WYrnnqlM54m0SUOrufPs1dW+X/PUht0hrmCfv6LLgPOyiQeuIfUw8LDEgxz+1/M
yb5JAvKAKfqg9EHpg8Lw9UVlDP4Y/Dfjn0Aup0a3JHeV0GbeYNVEaOdHMrZ3GEwGSZNqCdKQf48B
ls7GDpjIOmX0fBOOFAsssWLsF1BLAwQUAAAACAB1ta8uMYt/UDMBAADVAQAAAQAAADRNUFtPwjAU
fu+vOI9qputQfFisCWwQiU7IwBgfu/UMF9aW7AoS/rtr8UKafPnOd+lpSlyBrfsphE8IRFpgwYLw
+n3o3U/GDky7GFvm3dBnB5ZY5rx41YxAoFWWr9kBpvkOBcQodYs8KRDCVfzAhlFSGfboUcOUVhFf
K6zzFI4EYt4FT0tG3f44sCo3y/wLGTUL0vqXT4Ig2ddYMUpg3GTZar9F1qiN0p1yrHJKbvpHRnwX
NUVt6iZ+Ifk+wUsfgqY8W9RPJlGZ21/GI7bHypLqJBKYzePwg2nl6ixzoF7M5uwgc+V7A+p0rnUN
P/ZeGI3+vRJTqxPoKyD7L6x8gG2uqQHPwMDArYE7INC3/2KVkJxa9CwOQFpFWkVahcDbWaWxfmP9
q+YnMBItVymKRcSUJuQbUEsBAhkAFAAAAAgAdbWvLhkBN1qmAQAAcgIAAAEAAAAAAAAAAQAgAAAA
AAAAADFQSwECGQAUAAAACAB1ta8uVEUFR4YBAABAAgAAAQAAAAAAAAABACAAAADFAQAAMlBLAQIZ
ABQAAAAIAHW1ry5NTVamcAEAADICAAABAAAAAAAAAAEAIAAAAGoDAAAzUEsBAhkAFAAAAAgAdbWv
LjGLf1AzAQAA1QEAAAEAAAAAAAAAAQAgAAAA+QQAADRQSwUGAAAAAAQABAC8AAAASwYAAAAA

------=_NextPart_000_0007_01C31B3C.3B3F7CB0--

