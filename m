Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290946AbSBVBYK>; Thu, 21 Feb 2002 20:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290878AbSBVBXw>; Thu, 21 Feb 2002 20:23:52 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:7081 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S290827AbSBVBXs> convert rfc822-to-8bit;
	Thu, 21 Feb 2002 20:23:48 -0500
Date: Fri, 22 Feb 2002 02:23:28 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: =?gb2312?q?hanhbkernel?= <hanhbkernel@yahoo.com.cn>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: boot messeage
In-Reply-To: <20020222011800.95965.qmail@web15003.mail.bjs.yahoo.com>
Message-ID: <Pine.GSO.4.30.0202220222420.11273-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think you should use the append="quiet" option. This way use get only
errors shown.

On Fri, 22 Feb 2002, [gb2312] hanhbkernel wrote:

> When booting Linux, the kernel messages are shown on
> screen.
> I don't like to show these messages, so  "Support for
> console on virtual terminal" and "Support for console
> on serial port" are not chose when compiling kernel.
> But using the new kernel, computer can't boot. If one
> of "Support for console on virtual terminal" and
> "Support for console on serial port" is chose,
> Computer can be booted. If I don’t like the booting
> messages shown through terminal or HyperTerminal on
> screen.
> the following is my lilo.conf
> boot=/dev/hda
> map=/boot/map
> install=/boot/boot.b
> prompt
> timeout=50
> message=/boot/message
> linear
> default=linux-2.4.17
> image=/boot/linux2417
> 	label=linux-2.4.17
> 	initrd=/root/initrd
> 	append="root=/dev/ram0 init=linuxrc rw"
> I using append="console=quiet  root=/dev/ram0
> init=linuxrc rw" and
> append="console=/dev/null root=/dev/ram0 init=linuxrc
> rw" but computer can not be booted.
> Would you like to tell me how could I do?
>
>
>
> _________________________________________________________
> Do You Yahoo!?
> 到世界杯主题公园玩一玩，赢取世界杯门票乐一乐。
> http://cn.worldcup.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
pozsy

