Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVAUTEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVAUTEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVAUTDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:03:45 -0500
Received: from smtp3.poczta.onet.pl ([213.180.130.29]:1218 "EHLO
	smtp3.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262466AbVAUTD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:03:26 -0500
Message-ID: <41F15307.4030009@poczta.onet.pl>
Date: Fri, 21 Jan 2005 20:07:51 +0100
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
References: <41F11F79.3070509@poczta.onet.pl> <d120d500050121074831087013@mail.gmail.com>
In-Reply-To: <d120d500050121074831087013@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Hi,
> 
> What kernel version are you using? Have you tried 2.6.8.1? - it looks
> like changes in 2.6.9-rc2-bk3 caused problems on some hardware.
> 

Hi,

it looks like 2.6.10 (which I was using) - serio ports are detected ok 
(both on 0x60,0x64, keyboard irq 1, aux irq 12), keyboard also (AT 
Keyboard Translated Set 2 on isa0060/serio) and nothing - while 
detection NumLock (set by BIOS) is turned off and keyboard is dead. 
Maybe someone would be so kind and compare keyboard driver 
hadrware-level parts and (possibly) post patch reversing any changes 
since 2.4? Any other ideas?

(I use the newest gcc-3.3 if it matters.)
