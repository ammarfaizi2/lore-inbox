Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSBVBSa>; Thu, 21 Feb 2002 20:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290823AbSBVBST>; Thu, 21 Feb 2002 20:18:19 -0500
Received: from web15003.mail.bjs.yahoo.com ([61.135.128.6]:1299 "HELO
	web15003.mail.bjs.yahoo.com") by vger.kernel.org with SMTP
	id <S290767AbSBVBSM>; Thu, 21 Feb 2002 20:18:12 -0500
Message-ID: <20020222011800.95965.qmail@web15003.mail.bjs.yahoo.com>
Date: Fri, 22 Feb 2002 09:18:00 +0800 (CST)
From: =?gb2312?q?hanhbkernel?= <hanhbkernel@yahoo.com.cn>
Subject: boot messeage
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting Linux, the kernel messages are shown on
screen. 
I don't like to show these messages, so  "Support for
console on virtual terminal" and "Support for console
on serial port" are not chose when compiling kernel.
But using the new kernel, computer can't boot. If one
of "Support for console on virtual terminal" and
"Support for console on serial port" is chose,
Computer can be booted. If I don’t like the booting
messages shown through terminal or HyperTerminal on
screen.
the following is my lilo.conf
boot=/dev/hda
map=/boot/map
install=/boot/boot.b
prompt
timeout=50
message=/boot/message
linear
default=linux-2.4.17
image=/boot/linux2417
	label=linux-2.4.17
	initrd=/root/initrd
	append="root=/dev/ram0 init=linuxrc rw"
I using append="console=quiet  root=/dev/ram0
init=linuxrc rw" and  
append="console=/dev/null root=/dev/ram0 init=linuxrc
rw" but computer can not be booted.
Would you like to tell me how could I do?



_________________________________________________________
Do You Yahoo!? 
到世界杯主题公园玩一玩，赢取世界杯门票乐一乐。
http://cn.worldcup.yahoo.com/
