Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265500AbUGDKcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUGDKcd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 06:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUGDKcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 06:32:33 -0400
Received: from tag.witbe.net ([81.88.96.48]:22214 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S265500AbUGDKcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 06:32:32 -0400
Message-Id: <200407041032.i64AWTX21222@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Bernd Eckenfels'" <ecki-news2004-05@lina.inka.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Init single and Serial console : How to ?
Date: Sun, 4 Jul 2004 12:32:24 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <E1Bh3vk-0008Hb-00@calista.eckenfels.6bone.ka-ip.net>
Thread-Index: AcRhrwtNtyy11t7TSGSGoKSx/siFGQAAjYOQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> this is only about terminal settings like flags  and line 
> speed, it is not
> related to presenting the login on the serial console. It is 
> a good idea to
> remove this file and set the baud rate on the boot command line.
OK.
 
> You must configure /sbin/sulogin which is called from init to run on
> /dev/console, then you will be fine. Also you should start a getty on
OK, but remember that my problem is to find a way to access the machine
when I only have a serial console and it doesn't complete the "classical"
boot process because some init script at runlevel 3 is blocking...

This means that I can't go up to the "configure /sbin/sulogin", and need
a way to be given a serial prompt only by giving parameter at the LILO
prompt, considering that the kernel has already been configured for serial
console.

> /dev/ttySx for multi user modes (see the serial console howto)
This is already done.

Regards,
Paul

