Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbTLCRT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbTLCRT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:19:56 -0500
Received: from guardian.hermes.si ([193.77.5.150]:30471 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S265102AbTLCRTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:19:54 -0500
Message-ID: <600B91D5E4B8D211A58C00902724252C01BC046D@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Bugs in linux-2.6.0-test11/README
Date: Wed, 3 Dec 2003 18:19:45 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test11/README says :

 If you want
   to make a boot disk (without root filesystem or LILO), insert a floppy
   in your A: drive, and do a "make bzdisk".

Wasn't that feature (booting without LILO or other boot loader ) removed ?
At least http://www.kniggit.net/wwol26.html says so.


 - If you configured any of the parts of the kernel as `modules', you
   will have to do "make modules" followed by "make modules_install".
 
eh ? some other part says that "make modules" is now done as part of
"make"


...

   For some, this is on a floppy disk, in which case you can copy the
   kernel bzImage file to /dev/fd0 to make a bootable floppy.
 
...
again, see above.


Regards,
David
----------------------------------------------------------------------------
-----------
David Balazic                      mailto:david.balazic@hermes.si
HERMES Softlab                 http://www.hermes-softlab.com
Zolajeva 30                          Phone: +386 2 450 8851 
SI-2000 Maribor
Slovenija
----------------------------------------------------------------------------
-----------
"Be excellent to each other." -
Bill S. Preston, Esq. & "Ted" Theodore Logan
----------------------------------------------------------------------------
-----------





