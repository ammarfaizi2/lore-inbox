Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270755AbTHFNWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 09:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274997AbTHFNWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 09:22:20 -0400
Received: from iti.cs.uni-magdeburg.de ([141.44.26.1]:16515 "EHLO
	iti.cs.uni-magdeburg.de") by vger.kernel.org with ESMTP
	id S270755AbTHFNWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 09:22:16 -0400
Message-ID: <3F31014A.8060701@iti.cs.uni-magdeburg.de>
Date: Wed, 06 Aug 2003 15:23:22 +0200
From: Henner Graubitz <graubitz@iti.CS.Uni-Magdeburg.De>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Feedback 2.6.0-test2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I patched and tested 2.6.0-test2.

After patching and doing make oldconfig (of my working 2.4.21) I tried 
to compile the new kernel but it did not function:

Compiling stopped with


drivers/char/riscom8.c: In function `rc_release_drivers':
drivers/char/riscom8.c:1756: warning: implicit declaration of function 
`remove_bh'
drivers/char/riscom8.c:1756: `RISCOM8_BH' undeclared (first use in this 
function)
drivers/char/riscom8.c: At top level:
drivers/char/riscom8.c:84: warning: `DECLARE_TASK_QUEUE' declared 
`static' but never defined
make[3]: *** [drivers/char/riscom8.o] Fehler 1
make[2]: *** [drivers/char] Fehler 2
make[1]: *** [drivers] Fehler 2
make: *** [modules] Fehler 2

I also want to send you the output of scripts/ver_linux:

Linux laptop 2.4.21 #5 Mon Jul 7 11:58:18 CEST 2003 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.15
e2fsprogs              1.27
pcmcia-cs              3.1.33
PPP                    2.4.1
nfs-utils              1.0
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         apm nls_cp437 i810_audio ac97_codec ide-scsi 
soundcore usb-storage mousedev usbmouse keybdev usbkbd input usb-ohci 
usbcore


You do not have to respond on this mail. This is supposed just as 
feedback for your kernel.

Many thanks

Henner




-- 
Otto-von-Guericke-Universitaet Magdeburg
Institute of Technical and Business Information Systems
Research group KMD
Universitaetsplatz 2
39106 Magdeburg
Tel. +49-391-67-18189
FAX  +49-391-67-18110
http://wwwiti.cs.uni-magdeburg.de/~graubitz/

