Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135193AbRDRO2R>; Wed, 18 Apr 2001 10:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135189AbRDRO2H>; Wed, 18 Apr 2001 10:28:07 -0400
Received: from upsn13.u-psud.fr ([193.55.10.113]:51357 "EHLO upsn13.u-psud.fr")
	by vger.kernel.org with ESMTP id <S135185AbRDRO1v>;
	Wed, 18 Apr 2001 10:27:51 -0400
Message-ID: <3ADDA465.B936B916@fleming.u-psud.fr>
Date: Wed, 18 Apr 2001 16:27:50 +0200
From: Jaquemet Loic <jal@fleming.u-psud.fr>
X-Mailer: Mozilla 4.75 [fr] (X11; U; Linux 2.4.3-ac9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS problem
In-Reply-To: <150220000.987602630@tiny>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason a écrit :

> On Wednesday, April 18, 2001 01:44:04 PM +0200 Jaquemet Loic
> <jal@fleming.u-psud.fr> wrote:
>
> > Jaquemet Loic a écrit :
> > >> Sorry if this problem has already been disscussed.
> >> >> I run an linux box with a HD 30Go/reiserfs .
> >> I tried several 2.4 kernel ( 2.4.2 , 2.4.3 , 2.4.4-pre3 , 2.4.3-ac7)
> >> After a random time I've got a fs problem which lead to :
> >> -first a segfault of a process which reads/writes on the partition
> >> ex:
> >> [jal@skippy prog]$ ./configure
> >> ....
> >> ln -s dialects/linux/machine.h machine.h
> >> Erreur de segmentation ( SEGFAULT )
> >> >> -and then the partition freeze .Any attempt to read/write on it leads to
>
> Hmmm, are you sure there aren't any reiserfs messages on screen or in the
> log?
>
> -chris
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

there's nothing on the screen neither ine the logs about reiserfs ..
the onlys thing is that pointer NULL reference ..
Apr 18 11:55:26 skippy kernel: Unable to handle kernel NULL pointer dereference
at virtual address 00000000
Apr 18 11:55:26 skippy kernel:  printing eip:
Apr 18 11:55:26 skippy kernel: c019671a
Apr 18 11:55:26 skippy kernel: pgd entry c3f46000: 0000000000000000
Apr 18 11:55:26 skippy kernel: pmd entry c3f46000: 0000000000000000
Apr 18 11:55:26 skippy kernel: ... pmd not present!
Apr 18 11:55:26 skippy kernel: Oops: 0000
Apr 18 11:55:26 skippy kernel: CPU:    0

i've just changed 2.4.3ac7 to ac9 this ?morning? ( in france) . Waiting for the
crash ....


