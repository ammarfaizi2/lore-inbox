Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVAYTgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVAYTgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVAYTg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:36:28 -0500
Received: from smtp1.poczta.onet.pl ([213.180.130.31]:18614 "EHLO
	smtp1.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262082AbVAYTdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:33:22 -0500
Message-ID: <41F69FFE.2050808@poczta.onet.pl>
Date: Tue, 25 Jan 2005 20:37:34 +0100
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
References: <41F11F79.3070509@poczta.onet.pl>	 <d120d500050121074831087013@mail.gmail.com>	 <41F15307.4030009@poczta.onet.pl> <d120d500050121113867c82596@mail.gmail.com>
In-Reply-To: <d120d500050121113867c82596@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070604050802040904040308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070604050802040904040308
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

here you are gzip-ed dmesg from booting 2.6.8.1 - i've been playing 
keyboard while booting, maybe interrupt reports will help you. also my 
.config part follows:
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
no modules or other built-ins. maybe it is some simple way to fall back 
to old handling mechanism? in my system most of programs (i mean 
x-server) uses hardware directly (what means uses /dev/ttyS0 as mouse 
device). i'm grateful for any help.

---
May the Source be with you.
Witkor

--------------070604050802040904040308
Content-Type: application/gzip;
 name="dmesg2.6.8.1-dead-atkbd.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg2.6.8.1-dead-atkbd.gz"

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
--------------070604050802040904040308--
