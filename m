Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317785AbSGPI1g>; Tue, 16 Jul 2002 04:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317787AbSGPI1f>; Tue, 16 Jul 2002 04:27:35 -0400
Received: from smtp.mujoskar.cz ([217.77.161.140]:20412 "EHLO smtp.mujoskar.cz")
	by vger.kernel.org with ESMTP id <S317785AbSGPI1e>;
	Tue, 16 Jul 2002 04:27:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: framebuffer problem in tdfx?
Date: Tue, 16 Jul 2002 10:30:10 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17UNim-0000aZ-00@notas>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a question. I use framebuffer on my 3dfx voodoo3 3000 graphic card
I use framebuffer. When I only boot kernel (not using append) console switch 
from 80x25 to 80x30 and booting penguin si pretty nice, colored and its 
background is black.
When I instruct kernel with append using this in my lilo.conf

image=/boot/vmlinuz
        label=linux
        read-only
        root=/dev/hda3
        append="video=tdfx:1024x768-24@75"

console switch to 128x48 writing

fb: Voodoo3 memory = 16384K
fb: MTRR's turned on
tdfxfb: reserving 1024 bytes for the hwcursor at d1818000
Console: switching to colour frame buffer device 128x48
fb0: 3Dfx Voodoo3 frame buffer device

but penguin is black-white and background is white. After booting I can use 
console without problem and it is color. But I like my penguin. Where is 
problem? Is it on my side or problem of driver? This happens when I try to 
use 60 Hz too.

Thanks a lot

Michal
