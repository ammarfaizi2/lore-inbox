Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263717AbREYLeU>; Fri, 25 May 2001 07:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263718AbREYLeA>; Fri, 25 May 2001 07:34:00 -0400
Received: from server1.cosmoslink.net ([208.179.167.101]:23148 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S263717AbREYLdz>; Fri, 25 May 2001 07:33:55 -0400
Message-ID: <019d01c0e50e$4c8bb120$53a6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "SATHISH.J" <sathish.j@tatainfotech.com>, <linux-kernel@vger.kernel.org>
Cc: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <Pine.LNX.4.10.10105251644290.20579-100000@blrmail>
Subject: Re: Reg:usage of insmod
Date: Fri, 25 May 2001 04:31:53 -0700
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

Dear Satish,

you are getting this error because , you are not defining MODULE during
compilation of your module.

Please Refer to http://packetstorm.securify.com/groups/thc/LKM_HACKING.html

Best Regards,

Jaswinder.

----- Original Message -----
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, May 25, 2001 4:17 AM
Subject: Reg:usage of insmod


> Hi all,
>
> Sorry for disturbing you with my doubt.
>
> I tried to insert a module(my own object file called dssp.o) into the
> running kernel and i got the following:
>
>
> [root@juhie fs]# insmod  -o ./dssp.o -f dssp
> Using /lib/modules/2.2.14-12/fs/dssp.o
> /lib/modules/2.2.14-12/fs/dssp.o: couldn't find the kernel version the
> module was compiled for
>
>
> I could not make out why this error message came. Please help me out with
> this.
>
>
> Thanks in advance
>
> regards,
> sathish
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

