Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbUJaGhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbUJaGhh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 01:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbUJaGhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 01:37:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59041 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261511AbUJaGha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 01:37:30 -0500
Date: Sun, 31 Oct 2004 07:37:06 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
In-Reply-To: <1099170891.1424.1.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.53.0410310733220.3581@yvahk01.tjqt.qr>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> 
 <200410301228.42561.vda@port.imtp.ilyichevsk.odessa.ua> 
 <Pine.LNX.4.58.0410301040050.28839@ppc970.osdl.org> 
 <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
 <1099170891.1424.1.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If only glibc / X / KDE / OpenOffice (ugggh) people could hear you more...
>>
>>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
>> 15364 root      15   0 38008  26M 28496 S     0,0 10,8   0:57   0 kmail
>> 20022 root      16   0 40760  24M 23920 S     0,1 10,0   0:04   0 mozilla-bin
>>  1627 root      14  -1 71064  19M 53192 S <   0,1  7,9   3:16   0 X
>>  1700 root      15   0 25348  16M 23508 S     0,1  6,5   0:46   0 kdeinit
>>  3578 root      15   0 24032  14M 21524 S     0,5  5,8   0:23   0 konsole

Heh, and guess what: the people in #kde (irc.freenode.net for example) deny
that it's their fault with the statement "bah, that's shared libraries"!
If that's a lie or not, or a semi-lie, I'm definitely sure THAT libdcop libmcop
and every shitcrap that's running makes it almost impossible to run even on
Duron-800 w/256.

>Wow. evolution is now more bloated than kmail.
>
> 1424 rlrevell  15   0  125m  47m  29m S  7.8 10.1   1:41.78 evolution
> 1508 rlrevell  15   0 92432  30m  29m S  0.0  6.4   0:14.15 mozilla-bin
> 1090 root      16   0 55676  18m  40m S 24.8  3.9   0:46.98 XFree86
> 1379 rlrevell  15   0 33776  16m  18m S  0.3  3.5   0:06.65 nautilus
> 1377 rlrevell  15   0 19392  11m  15m S  0.0  2.5   0:03.29 gnome-panel
> 1458 rlrevell  16   0 28188  11m  15m S  3.9  2.5   0:10.44 gnome-terminal
> 1307 rlrevell  15   0 20828  11m  17m S  0.0  2.4   0:03.08 gnome-settings-

Gnome is no better. (Flamewar: I like ICEWM)

The only thing more bloated is the X server itself when it runs with the
proprietary NV GL core:

USER   PID MEM%    VSZ   RSZ STAT START   TIME COMMAND
root  5220  7.8 417872 20220 SL   08:37   0:03 X -noliste[...]


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
