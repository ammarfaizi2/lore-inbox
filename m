Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbUKNRs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbUKNRs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 12:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUKNRs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 12:48:28 -0500
Received: from [81.23.229.73] ([81.23.229.73]:409 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261320AbUKNRsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 12:48:21 -0500
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: mahashakti89@wanadoo.fr
Subject: Re: Syscontrol activation = problem on boot
Date: Sun, 14 Nov 2004 18:48:16 +0100
User-Agent: KMail/1.6.2
References: <4197977B.5080400@wanadoo.fr>
In-Reply-To: <4197977B.5080400@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411141848.16106.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have similar errors, but they don't give me any problems (except that it 
looks bad).
Can you mount and use the harddisk?

Regards,

Norbert

On Sunday 14 November 2004 18:35, mahashakti89 wrote:
> Hi !
>
> This is my first post on this list, and I could need some help
> to know if I made something wrong or if it is a bug ....
>
> I compiled a new kernel and activated following option
>
> General Setup > Sysctrl Support
>
> in order to be able to use hotplug , udev  .....
>
> But on boot I become following error message concerning
> my second harddisk (/dev/hdb) which is dedicated to my
> old Win2k system :
>
>   Nov 12 19:15:13 ishwara kernel: hdb: read_intr: status=0x59 {
> DriveReady SeekComplete DataRequest Error }
>
>  > Nov 12 19:15:13 ishwara kernel: hdb: read_intr: error=0x04 {
>
> DriveStatusError }
>
>  > Nov 12 19:15:13 ishwara kernel: ide: failed opcode was: unknown
>  > Nov 12 19:15:13 ishwara kernel: end_request: I/O error, dev hdb,
>
> sector 78172098
>
>  > Nov 12 19:15:13 ishwara kernel: Buffer I/O error on device hdb5,
>
> logical block 61785735
>
> it can last two or three minutes and then I have accsess to my
> Gnome Desktop.
>
> This arrives on a 2.6.7 or 2.6.9 kernel if I try to activate Sysctrl
> in General Setup, if I deactivate it, I have not such error messages ....
>
> To resume it : Is it a bug ? Or did I make something wrong ? Forget some
> options ?
>
>
> System : Pentium 4 2,8Ghz
>           Motherboard Asus P4P 800
>           Chipset I865PE
>           and two Maxtor ATA-Harddisks
>
> Thanks for helping
>
> mahahshakti89
>
> Please Cc your answers to mahashakti89@wanadoo.fr
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
