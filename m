Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264674AbSJTXuc>; Sun, 20 Oct 2002 19:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSJTXuc>; Sun, 20 Oct 2002 19:50:32 -0400
Received: from dgesmtp01.wcom.com ([199.249.16.16]:17652 "EHLO
	dgesmtp01.wcom.com") by vger.kernel.org with ESMTP
	id <S264674AbSJTXub>; Sun, 20 Oct 2002 19:50:31 -0400
Date: Sun, 20 Oct 2002 18:53:55 -0500
From: steve roemen <steve.roemen@wcom.com>
Subject: RE: 2.5.44 PIIX4 ide oops on boot
In-reply-to: <Pine.LNX.4.44.0210201757470.860-100000@dad.molina>
To: "'Thomas Molina'" <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Reply-to: steve.roemen@wcom.com
Message-id: <005901c27893$f36cbab0$e70a7aa5@WSXA7NCC106.wcomnet.com>
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

