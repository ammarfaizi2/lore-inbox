Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263286AbTJUBCz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 21:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbTJUBCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 21:02:55 -0400
Received: from mail.baldwinlib.org ([209.104.139.7]:4014 "EHLO
	mail.baldwinlib.org") by vger.kernel.org with ESMTP id S263286AbTJUBCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 21:02:53 -0400
Message-ID: <35351.68.40.98.164.1066698173.squirrel@mail.baldwinmail.org>
Date: Mon, 20 Oct 2003 21:02:53 -0400 (EDT)
Subject: x86_64 aacraid help
From: "George Glover" <gloverge@baldwinlib.org>
To: linux-kernel@vger.kernel.org
Reply-To: gloverge@baldwinlib.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a dual opteron machine, running a cross compiled test7 on a 32 bit
distro.  2 gigs of ram, irqbalanced, everything seems to run very well -
except for the aacraid driver.

It's an Adaptec 2200S, with 5 U320 drives connected (seperate channels
3/2).  Each drive seems to read ~70MB/s on it's own, both through the
aacraid driver and through the onboard fusion mpt controller.  Using
hardware raid 10 with aacraid reads ~100MB/s, it seems to go no faster -
regardless of raid levels.  However with software raid, I can nearly
double that (half on aacraid, half onboard)  I am not able to test it with
all drives using the onboard controller with software raid due to lack of
cables and not wanting to destroy the boot drive.

I am wondering if there is a magical go faster button that I'm missing?

Thank you,

George
