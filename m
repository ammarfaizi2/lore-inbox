Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUBPXgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265967AbUBPXgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:36:36 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:36868 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S265966AbUBPXge convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:36:34 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 input drivers FAQ (ir-kbd-gpio.ko)
Date: Tue, 17 Feb 2004 00:36:21 +0100
User-Agent: KMail/1.6.1
References: <20040201100644.GA2201@ucw.cz> <20040201215438.GA8937@localhost> <20040216224226.GB322@elf.ucw.cz>
In-Reply-To: <20040216224226.GB322@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402170036.21590.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Monday 16 of February 2004 23:42, Pavel Machek napisa³:
> > So it seems the new kernel driver for TV capture card based remote
> > controls doesn't use /dev/lirc as the place to "send" events from which
> > applications read them.
>
> Exactly. With this driver, this is just another keyboard, not lirc
> device. You should not need lircd.
I have no idea how to use lirc ready apps without lircd but cvs version of 
lircd is able to deal with ir-kbd drivers - it reads events 
from /dev/input/eventX.

> 								Pavel

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
