Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276507AbRJPQyr>; Tue, 16 Oct 2001 12:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276522AbRJPQyh>; Tue, 16 Oct 2001 12:54:37 -0400
Received: from web20908.mail.yahoo.com ([216.136.226.230]:33610 "HELO
	web20908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276483AbRJPQy3>; Tue, 16 Oct 2001 12:54:29 -0400
Message-ID: <20011016165501.13116.qmail@web20908.mail.yahoo.com>
Date: Tue, 16 Oct 2001 18:55:01 +0200 (CEST)
From: =?iso-8859-1?q?Jan=20Meyer?= <janmeyer2604@yahoo.de>
Subject: mysterious ide-scsi error messages
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a problem with ide-scsi emulation and LILO.
After invoking LILO in order to write a new bootsector
the following kernel error message is written to my
syslog:

----8<----
Oct  2 18:00:21 hal kernel: ide-scsi: hda: unsupported
command in request queue
(0)
Oct  2 18:01:32 hal last message repeated 780 times
Oct  2 18:02:36 hal last message repeated 260 times
Oct  2 18:02:37 hal last message repeated 31 times
---->8----

I use the ide-scsi emulation to access my CD Writer
(/dev/hda and respectively /dev/sg0 and /dev/sr0), a
Sony CD-RW CRX145E. It is the only device attached to
a VIA vt82c686a (rev 22) IDE-Controller. ide-scsi
emulation is compiled as a module, all in all the
following modules are loaded: ide-scsi, scsi_mod,
sr_mod, sg. Additionally the hda=ide-scsi
bootparameter is given to the kernel at booting time.
This happens with all Kernel versions that I tried so
far, from 2.4.7 up to the latest 2.4.12 and _only_
when invoking LILO (21.7.5). /dev/hda is in no way
mentioned in lilo.conf since I boot from /dev/hde,
also turning on verbose scsi error messages doesn't
add any additional information to this mysterious
message. Please notice that everything else like
reading and writing works just fine with this device.

Does anybody know what these messages mean and how
they can be avoided?

Please CC me your replies since I'm not subscribed to
the list. Thanks a lot.

Jan Meyer

__________________________________________________________________

Es ist soweit: das Nokia Game beginnt. Sei bereit für das multimediale Abenteuer. Melde dich bis zum 3. November bei http://de.promotions.yahoo.com/info/nokiagame an!
