Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264701AbSJUC5b>; Sun, 20 Oct 2002 22:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264704AbSJUC5b>; Sun, 20 Oct 2002 22:57:31 -0400
Received: from pmesmtp01.wcom.com ([199.249.20.1]:15291 "EHLO
	pmesmtp01.wcom.com") by vger.kernel.org with ESMTP
	id <S264701AbSJUC53>; Sun, 20 Oct 2002 22:57:29 -0400
Date: Sun, 20 Oct 2002 22:03:27 -0500
From: steve roemen <steve.roemen@wcom.com>
Subject: RE: 2.5.44/2.5.44-mm1 PIIX4 ide oops on boot
In-reply-to: 
To: steve.roemen@wcom.com, "'Thomas Molina'" <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Reply-to: steve.roemen@wcom.com
Message-id: <005a01c278ae$6e1d93f0$e70a7aa5@WSXA7NCC106.wcomnet.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V4.72.3719.2500
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i get the same results with Andrew Morton's 2.5.44-mm1 patch

-----Original Message-----
From: steve roemen [mailto:steve.roemen@wcom.com]
Sent: Sunday, October 20, 2002 6:54 PM
To: 'Thomas Molina'
Cc: 'linux-kernel@vger.kernel.org'
Subject: RE: 2.5.44 PIIX4 ide oops on boot


thanks for the tip on ide-cd, but i get a similar oops.

-steve

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Thomas Molina
Sent: Sunday, October 20, 2002 5:59 PM
To: steve roemen
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 PIIX4 ide oops on boot


On Sun, 20 Oct 2002, steve roemen wrote:

>
> attached is the oops, the config,  and some info on the box.
>
> ide is only used for the cdrom.
>
> it oopes during bootup.  also, if i remove ide from this kernel, it'll
boot
> on the scsi drive just fine.
>
> 2.4.19 works just fine on this box.

Your config says you have ide-cd configured.  Try taking just ide-cd out
and reboot.  I've found a problem with 2.5.44 and ide-cd on my system
also.  I have a similar oops on boot or module insertion.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

