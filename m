Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266921AbRHKKQM>; Sat, 11 Aug 2001 06:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267419AbRHKKQC>; Sat, 11 Aug 2001 06:16:02 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:53262 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266921AbRHKKPw>; Sat, 11 Aug 2001 06:15:52 -0400
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Sat, 11 Aug 2001 11:16:37 +0100
From: quintaq@yahoo.co.uk
To: <linux-kernel@vger.kernel.org>
Subject: Errors compiling emu10k1 module under 2.4.8
Reply-To: quintaq@yahoo.co.uk
X-Mailer: Sylpheed version 0.5.2 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010811101557Z266921-760+224@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just d/ld the 2.4.8 patch and compilation of emu10k1 fails with :

main.o(.modinfo+0x20): multiple definition of `__module_author'
joystick.o(.modinfo+0x80): first defined here
ld: Warning: size of symbol `__module_author' changed from 67 to 81 in
main.o
main.o(.modinfo+0x80): multiple definition of `__module_description'
joystick.o(.modinfo+0xe0): first defined here
ld: Warning: size of symbol `__module_description' changed from 83 to 96 in
main.o
main.o: In function `init_module':
main.o(.text+0x1878): multiple definition of `init_module'
joystick.o(.text+0x240): first defined here
ld: Warning: size of symbol `init_module' changed from 64 to 67 in main.o
main.o: In function `cleanup_module':
main.o(.text+0x18bc): multiple definition of `cleanup_module'
joystick.o(.text+0x280): first defined here
make[3]: *** [emu10k1.o] Error 1

etc

Has my patching gone awry or is this a bug ?

I am not subscribed to the list, so a cc'd reply would be nice.

Thanks,

Geoff

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

