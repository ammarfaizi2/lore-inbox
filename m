Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264989AbUELGJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264989AbUELGJa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 02:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUELGJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 02:09:30 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6876 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S264989AbUELGJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 02:09:28 -0400
Date: Wed, 12 May 2004 00:09:32 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <008201c437e7$b1a35160$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.jr282gn.1ni2t37@ifi.uio.no> <fa.cmd38j8.1tgg9ro@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this is indeed the case, that those drives don't support the "flush write
cache" command, I'd like to see Maxtor's excuse as to why.. I believe that
Windows always powers down IDE drives before shutdown, maybe this is because
of non-universal support for the "flush write cache" command?


----- Original Message ----- 
From: "Rene Herman" <rene.herman@keyaccess.nl>
Newsgroups: fa.linux.kernel
To: <gene.heskett@verizon.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, May 10, 2004 6:08 AM
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"


> Gene Heskett wrote:
>
> >> hda: Maxtor 6Y120P0, ATA DISK drive
>
> > I note the drive is the same model here too, Rene.
> >
> > The question remains however, is our data in danger?
>
> There's a fair change that we'll be told, yes, very much so, since these
> drives don't seem to correctly support this life saving feature. The
> real answer though will be more easily deducted by calculating the ratio
> of unexplained file system corruptions you've had and reboots you've
> managed (0, that is).
>
> Rene.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

