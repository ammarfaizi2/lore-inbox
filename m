Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTGGV2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 17:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTGGV2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 17:28:07 -0400
Received: from 11.ylenurme.ee ([193.40.6.11]:4235 "HELO linking.ee")
	by vger.kernel.org with SMTP id S264495AbTGGV2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 17:28:00 -0400
Date: Tue, 8 Jul 2003 00:42:32 +0300 (EEST)
From: Elmer <elmer@linking.ee>
X-X-Sender: elmer@server.linking.sise
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-ac4 Adaptec 1210SA lost interrupt , Seagate 120G
Message-ID: <Pine.LNX.4.44.0307080017060.2847-100000@server.linking.sise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tried them on every imaginable way:

1. 2.4.21 + my own siimage slight patch, 2.4.21 + simage from ac4, 
	pure 2.4.21-ac4
2. apic, noapic, localapic
3. uni,smp motherboards, 4 of them
4. modules, compiled in, 
5. all of options from cards bios

/proc/interrupts reports 0 interrupts for ide2,3 , whatever I do.

after bootup, after attacking ide-disk driver, there are lost interrupts.
it recognises disk as correct type, but no communication except:

1. under XP it works (but there was no linux at that mb) 
2. hdparm lets change few flags under linux, but no -X succeeds
3. after waiting for minute those timeouts and booting up, then 
/proc/ide/ide2/hde/*  reports sensible correct information

I have the card for few more days, anything to try ?

Elmer.


