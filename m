Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136399AbREDONG>; Fri, 4 May 2001 10:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136398AbREDOM4>; Fri, 4 May 2001 10:12:56 -0400
Received: from wks79.navicsys.com ([207.180.73.79]:53211 "EHLO noop")
	by vger.kernel.org with ESMTP id <S136395AbREDOMm>;
	Fri, 4 May 2001 10:12:42 -0400
To: linux-kernel@vger.kernel.org
Subject: console=ttyS0 doesn't work 2.4.4
From: Nick Papadonis <npapadon@yahoo.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Content-Type: text/plain; charset=US-ASCII
Date: 04 May 2001 10:09:43 -0400
Message-ID: <m3zoct9peg.fsf@yahoo.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compiled the Linux kernel v2.4.4 and can't get 'console=ttyS0,115200
console=tty0' to work.  This appended line works fine when I boot
into my 2.2.x series kernel.

Anyone have similar problems?  Has anyone verified serial console
output works with the 2.4.x kernels?  Thanks.

- Nick

Here is my /etc/lilo.conf:
boot=/dev/hda
map=/boot/map
install=/boot/boot.b
prompt
timeout=50
message=/boot/message
linear
default=linuxold
append="console=ttyS0,115200 console=tty0"

image=/boot/vmlinuz-2.2.16-22
        label=linuxold
        read-only
        root=/dev/hda6

image=/boot/vmlinuz-2.4.4
        label=linux
        read-only
        root=/dev/hda6

