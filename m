Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTGBUm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbTGBUm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:42:59 -0400
Received: from 200-204-171-188.insite.com.br ([200.204.171.188]:40712 "HELO
	proxy.inteliweb.com.br") by vger.kernel.org with SMTP
	id S264487AbTGBUm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:42:57 -0400
Message-ID: <01b101c340dc$ede386c0$3300a8c0@Slepetys>
From: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>, <linux-kernel@vger.kernel.org>
References: <00d901c340a8$810556c0$3300a8c0@Slepetys> <1083830000.1057158848@aslan.scsiguy.com>
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
Date: Wed, 2 Jul 2003 18:00:12 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I upgraded it for the 6.2.36, using RPM and I am making some heavy tests.

Until now, it's ok, and for this kind of tests, the old configuration gave
some trouble.

Thanks
Slepetys

----- Original Message ----- 
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>;
<linux-kernel@vger.kernel.org>
Sent: Wednesday, July 02, 2003 12:14 PM
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble


> > The system halts easily if I do a large I/O, like reindexing a database,
> > giving me some messages like: (scsi0:A:1:0): Locking max tag count at
128...
>
> The "Locking max tag count" messages are normal.  It means the SCSI
> driver was able to determine the maximum queue depth of your drive.
>
> 6.2.8 is rather old.  I don't know that upgrading the aic7xxx driver
> will solve your problem, but it might be worth a shot.  The latest
> is available here:
>
> http://people.FreeBSD.org/~gibbs/linux/SRC/
>
> After upgrading, you should be at 6.2.36.
>
> --
> Justin
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


