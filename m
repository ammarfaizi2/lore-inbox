Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280805AbRLQPvi>; Mon, 17 Dec 2001 10:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280938AbRLQPv2>; Mon, 17 Dec 2001 10:51:28 -0500
Received: from Expansa.sns.it ([192.167.206.189]:6406 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S280805AbRLQPvR>;
	Mon, 17 Dec 2001 10:51:17 -0500
Date: Mon, 17 Dec 2001 16:50:47 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <raul@viadomus.com>
cc: <adam@tabris.net>, <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Is /dev/shm needed?
In-Reply-To: <E16Fkqc-0001Z0-00@DervishD.viadomus.com>
Message-ID: <Pine.LNX.4.33.0112171650240.23966-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Dec 2001, RaúlNúñez de Arenas  Coronado wrote:

>     Hello Adam :))
>
> >> have lots of memory to spare, give it a try.  Mount /tmp or all of /var
> >> in tmpfs.
> >Unfortunately, some(many?) distros are b0rken in re /var/. There is
> >stuff put there that is needed across boots (for example, mandrake
> >puts the DNS master files in /var/named.)
>
>     Moreover, didn't the LHS say that /var/tmp is supposed to be
> maintained across reboots? I'm not sure about this, but anyway /var
> is supposed to hold temporary data, not boot-throwable data, isn't
> it?
yes, just think to sysstem logs...
>
>     Raúl
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

