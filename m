Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSHaWEl>; Sat, 31 Aug 2002 18:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSHaWEl>; Sat, 31 Aug 2002 18:04:41 -0400
Received: from emerald3.kumin.ne.jp ([210.132.100.202]:9176 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S318028AbSHaWEk>; Sat, 31 Aug 2002 18:04:40 -0400
Message-Id: <200208312208.AA00121@prism.kumin.ne.jp>
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
Date: Sun, 01 Sep 2002 07:08:57 +0900
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.32 boot up but hang up
In-Reply-To: <Pine.LNX.4.44.0208311545150.17857-100000@linux-box.realnet.co.sz>
References: <Pine.LNX.4.44.0208311545150.17857-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Check all your input options, don't forget CONFIG_SERIO* too.
>

I checked CONFIG_SERIO, and update kernel paramter.
I update CONFIG_SERIO=y , CONFIG_SERIO_I8042=y, CONFIG_KEYBOARD_ATKBD=y.
Then recompile kernel, boot up, and kernel-2.5.21 work fine.
Thank you.

==== Input devices parameter ====

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_I8042_REG_BASE=60
CONFIG_I8042_KBD_IRQ=1
CONFIG_I8042_AUX_IRQ=12
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
