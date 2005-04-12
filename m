Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVDLDAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVDLDAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 23:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVDLDAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 23:00:51 -0400
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:63904 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262005AbVDLDAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 23:00:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Manu <manuel.dahmen@gmail.com>
Subject: Re: [Bug?] Keyboard Problem
Date: Mon, 11 Apr 2005 19:04:11 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <9c579ec805041116459041006@mail.gmail.com>
In-Reply-To: <9c579ec805041116459041006@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504111904.11989.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 11 April 2005 18:45, Manu wrote:
> I'm currently using a 2.6.10 kernel (on a Debian Sarge, i386).
> 
> I've compiled a 2.6.11.5 and a 2.6.11.7 kernels and my keyboard (a
> sweex SILVER MULTIMEDIA KEYBOARD, SW-23 -- PS/2 105 keys -- a
> classical keyboard) doesn't work with these kernels.
...
> CONFIG_EMBEDDED=y
...
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> # CONFIG_SERIO_I8042 is not set

You need to enable i8042 support - that's your keyboard controller.

Also, is there a specific reason why you enabled "embedded" mode? In
normal mode i8042 would be selected automatically...

-- 
Dmitry
