Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbUKNRui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbUKNRui (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 12:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUKNRui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 12:50:38 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34754 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261323AbUKNRua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 12:50:30 -0500
Date: Sun, 14 Nov 2004 18:50:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: mahashakti89 <mahashakti89@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Syscontrol activation = problem on boot
In-Reply-To: <4197977B.5080400@wanadoo.fr>
Message-ID: <Pine.LNX.4.53.0411141846150.20107@yvahk01.tjqt.qr>
References: <4197977B.5080400@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Nov 12 19:15:13 ishwara kernel: hdb: read_intr: status=0x59 {
>DriveReady SeekComplete DataRequest Error }
> > Nov 12 19:15:13 ishwara kernel: hdb: read_intr: error=0x04 {
>DriveStatusError }
> > Nov 12 19:15:13 ishwara kernel: ide: failed opcode was: unknown
> > Nov 12 19:15:13 ishwara kernel: end_request: I/O error, dev hdb,
>sector 78172098
> > Nov 12 19:15:13 ishwara kernel: Buffer I/O error on device hdb5,
>logical block 61785735

Looks like an old harddisk that does not understand an IDE command.

>it can last two or three minutes and then I have accsess to my
>Gnome Desktop.

Do you think that's normal? I can come up in less than 60 secs. (80x25), so I
presume boting X does not take much more time than 3 minutes.
What do you mean by "last"? Does the error message stay there and the box is
like, idle? No other stuff scrolling through?

>This arrives on a 2.6.7 or 2.6.9 kernel if I try to activate Sysctrl
>in General Setup, if I deactivate it, I have not such error messages ....

Well, error message there or not -- I suspect it to be the hard disk.
Take it out (i.e. remove IDE cable) and reboot Linux.
If it takes the same amount of time to bootup, the hard disk is probably fine.
Ignore the warnings then.

>          and two Maxtor ATA-Harddisks

>

Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
