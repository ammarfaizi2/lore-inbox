Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWBMMbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWBMMbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWBMMbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:31:48 -0500
Received: from smtp.enternet.hu ([62.112.192.21]:4359 "EHLO smtp.enternet.hu")
	by vger.kernel.org with ESMTP id S932413AbWBMMbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:31:47 -0500
Message-ID: <003901c6309a$627995b0$9d00a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>
References: <01c801c63039$de70c780$9d00a8c0@dcccs> <Pine.LNX.4.61.0602131008320.2682@yvahk01.tjqt.qr>
Subject: Re: [QUESTION] NFS and new kernels.
Date: Mon, 13 Feb 2006 13:38:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, February 13, 2006 10:09 AM
Subject: Re: [QUESTION] NFS and new kernels.


>
> >This tells me: i am the stupid. :-)
> >
> >The general problem, is this:
> >
> >(client)[root@st-0001 root]# mount: 192.168.0.2://mountpoint failed,
reason
> >given by server: Permission denied
>
> Bogus syntax, I'd say. //mountpoint is not the same as /mountpoint

Ahh, yes, you have right!
But i use this format from the beginning, and was worked until now.

Anyway, now i try with one / but no change!

The problem, is somewhere else!

Thanks,
Janos

>
> >(server)[root@NetCenter log]# mount: localhost://mountpoint failed,
reason
> >given by server: Permission denied
> >(client)[root@st-0001 root]# showmount -e 192.168.0.2
> >/mnt/EXT                192.168.2.*
> >/mnt/EXT/NFS/ROOT       (everyone)
> >/mountpoint            st-0001
> >etc...
> >
>
> Jan Engelhardt
> -- 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

