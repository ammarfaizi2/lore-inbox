Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289481AbSAOKHT>; Tue, 15 Jan 2002 05:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289476AbSAOKHE>; Tue, 15 Jan 2002 05:07:04 -0500
Received: from smtp2.orcon.net.nz ([210.55.12.15]:61714 "EHLO
	smtp2.orcon.net.nz") by vger.kernel.org with ESMTP
	id <S289473AbSAOKGy>; Tue, 15 Jan 2002 05:06:54 -0500
Message-ID: <002001c19dac$6a34de70$0100000a@orcon.net>
From: "Craig Whitmore" <lennon@orcon.net.nz>
To: "A Guy Called Tyketto" <tyketto@wizard.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020115094953.GA24170@wizard.com>
Subject: Re: atyfb in 2.5.2
Date: Tue, 15 Jan 2002 23:06:52 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "A Guy Called Tyketto" <tyketto@wizard.com>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, January 15, 2002 10:49 PM
Subject: atyfb in 2.5.2


>
>         No go for compiling in 2.5.2:
>
> make[2]: Entering directory `/usr/src/linux/drivers/video'
> make -C aty
> make[3]: Entering directory `/usr/src/linux/drivers/video/aty'
> make all_targets
> make[4]: Entering directory `/usr/src/linux/drivers/video/aty'
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -
pipe
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
> -DEXPORT_SYMTAB -c atyfb_base.c
> atyfb_base.c: In function `aty_init':
> atyfb_base.c:1989: incompatible types in assignment

I get the same for the rivafb as well (looks like all the fb stuff actually)

   info->node = -1;

commenting out that line made it so it compiled and worked (well looked like
it did when using it , but may not be 100% right )

I dunno if it the right thing to do for the aty FB as well

Can anyone got a proper fix for this?


Thanks
Craig Whitmore
http://www.orcon.net.nz



