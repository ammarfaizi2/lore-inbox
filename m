Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135180AbRD3KuQ>; Mon, 30 Apr 2001 06:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135181AbRD3KuH>; Mon, 30 Apr 2001 06:50:07 -0400
Received: from mailgate2.zdv.Uni-Mainz.DE ([134.93.8.57]:16364 "EHLO
	mailgate2.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S135180AbRD3Ktx>; Mon, 30 Apr 2001 06:49:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Olaf Stetzer <ostetzer@mail.uni-mainz.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Severe problems when mounting vfat partitions
Date: Mon, 30 Apr 2001 12:08:01 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <200104281818.UAA02498@kufel.dom>
In-Reply-To: <200104281818.UAA02498@kufel.dom>
MIME-Version: 1.0
Message-Id: <01043012080300.00851@Seaborg>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 28. April 2001 20:18 schrieb Andrzej Krzysztofowicz:
> > Dweezil:~# mount -t msdos /dev/hda5 /mnt
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000004
>
> One-bit-from-zero address suggests hardware memory problem.
> Did you try to change memory chips ?
>
No, but I solved the problem yesterday at 3:00 in the night! A recompiled
kernel (this time: 2.2.19) did the trick. However, the previous kernels I
compiled with different options were not installed correctly. To be 
precise: I have a small /boot partition where I store the kernels to
boot, but unfortunately make bzlilo was not aware of that fact and so
running lilo always installed the old broken 2.2.17! 

Maybe the error had something to do with other problems mentioned
about a VIA KT133 bug (data corruption...something) but I am quite
happy that I can work again!

Bye,

Olaf
