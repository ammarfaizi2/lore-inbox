Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267146AbSLQVWc>; Tue, 17 Dec 2002 16:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267148AbSLQVWc>; Tue, 17 Dec 2002 16:22:32 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:41601 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S267146AbSLQVWb>; Tue, 17 Dec 2002 16:22:31 -0500
Subject: Re: 2.5.52 compile error
From: Steven Cole <elenstev@mesatop.com>
To: Bob Miller <rem@osdl.org>
Cc: rtilley <rtilley@vt.edu>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021217211618.GB1069@doc.pdx.osdl.net>
References: <3E058049@zathras>  <20021217211618.GB1069@doc.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 17 Dec 2002 14:29:11 -0700
Message-Id: <1040160551.16547.27.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 14:16, Bob Miller wrote:
> On Tue, Dec 17, 2002 at 03:57:01PM -0500, rtilley wrote:
> > Using RH's default *i686.config to build a vanilla 2.5.52 kernel. It keeps 
> > returning this error on 2 totally different x86 PCs:
> > 
> > 
> > drivers/built-in.o: In function `kd_nosound':
> > drivers/built-in.o(.text+0x1883f): undefined reference to `input_event'
[more errors snipped]
> > 
> > Where is the fix for this?
> > 
> At your finger tips ;-).  Turn on CONFIG_INPUT via "Input device support"
> off the main page.

And if you want to use your keyboard or mouse, something similar to the
following may be helpful, depending on your system.

CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y

Steven



