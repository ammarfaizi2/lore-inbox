Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129913AbRAaVYg>; Wed, 31 Jan 2001 16:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130633AbRAaVYR>; Wed, 31 Jan 2001 16:24:17 -0500
Received: from cannet.com ([206.156.188.2]:61709 "HELO mail.cannet.com")
	by vger.kernel.org with SMTP id <S129913AbRAaVYK>;
	Wed, 31 Jan 2001 16:24:10 -0500
Message-ID: <003701c08bcc$19b8bae0$7930000a@hcd.net>
From: "Timothy A. DeWees" <whtdrgn@mail.cannet.com>
To: Lukasz Gogolewski <lucas@supremedesigns.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3A787D97.CBF7B327@supremedesigns.com>
Subject: Re: problems with sblive as well as 3com 3c905
Date: Wed, 31 Jan 2001 16:23:44 -0500
Organization: Himebaugh Consulting, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need to create a symlink

ln -s /lib/modules/2.4.1/kernel/drivers/net /lib/modules/2.4.1/net

That will fix the nic, I am not sure about sound.  You may need to
create a misc link like

ln -s /lib/modules/2.4.1/kernel/drivers/misc /lib/modules/2.4.1/misc


----- Original Message -----
From: "Lukasz Gogolewski" <lucas@supremedesigns.com>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, January 31, 2001 4:03 PM
Subject: problems with sblive as well as 3com 3c905


> After I compiled kernel 2.4.1 on rh 6.2 I enabled module support for 2
> of those devices.
>
> However when I rebooted my machine both of those devices are not
> working.
>
> I don't know what's wrong since I did make moudle and make
> module_install.
>
> When I try to configure mdoule for the sound card, I get a message
> saying that module wasn't found.
>
> For the network card I get Delaying initialization
>
> any suggestions on how to fix it?
>
> - Lucas
>
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
