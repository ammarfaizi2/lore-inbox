Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUKNRek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUKNRek (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 12:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUKNRek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 12:34:40 -0500
Received: from smtp10.wanadoo.fr ([193.252.22.21]:18857 "EHLO
	mwinf1007.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261321AbUKNReh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 12:34:37 -0500
Message-ID: <4197977B.5080400@wanadoo.fr>
Date: Sun, 14 Nov 2004 18:35:55 +0100
From: mahashakti89 <mahashakti89@wanadoo.fr>
Reply-To: mahashakti89@wanadoo.fr
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr, en-us, de-de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: mahashakti89@wanadoo.fr
Subject: Syscontrol activation = problem on boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This is my first post on this list, and I could need some help
to know if I made something wrong or if it is a bug ....

I compiled a new kernel and activated following option

General Setup > Sysctrl Support

in order to be able to use hotplug , udev  .....

But on boot I become following error message concerning
my second harddisk (/dev/hdb) which is dedicated to my
old Win2k system :

  Nov 12 19:15:13 ishwara kernel: hdb: read_intr: status=0x59 { 
DriveReady SeekComplete DataRequest Error }

 > Nov 12 19:15:13 ishwara kernel: hdb: read_intr: error=0x04 { 
DriveStatusError }
 > Nov 12 19:15:13 ishwara kernel: ide: failed opcode was: unknown
 > Nov 12 19:15:13 ishwara kernel: end_request: I/O error, dev hdb, 
sector 78172098
 > Nov 12 19:15:13 ishwara kernel: Buffer I/O error on device hdb5, 
logical block 61785735

it can last two or three minutes and then I have accsess to my
Gnome Desktop.

This arrives on a 2.6.7 or 2.6.9 kernel if I try to activate Sysctrl
in General Setup, if I deactivate it, I have not such error messages ....

To resume it : Is it a bug ? Or did I make something wrong ? Forget some 
options ?


System : Pentium 4 2,8Ghz
          Motherboard Asus P4P 800
          Chipset I865PE
          and two Maxtor ATA-Harddisks

Thanks for helping

mahahshakti89

Please Cc your answers to mahashakti89@wanadoo.fr
