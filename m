Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVIJWkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVIJWkE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVIJWjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:39:54 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:39554 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932345AbVIJWjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:39:47 -0400
Message-ID: <432360A2.7040608@gmail.com>
Date: Sun, 11 Sep 2005 00:39:30 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] (i)stallion remove
References: <200509101221.j8ACL9XI017246@localhost.localdomain> <43234860.7050206@pobox.com> <43234972.3010003@gmail.com> <20050910211711.GA13660@suse.de> <4323518E.9060407@gmail.com> <432352F0.1080502@pobox.com>
In-Reply-To: <432352F0.1080502@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> If the drivers aren't used or maintained, remove them from the kernel 
> tree.

So, this as a first:

(I)stallion remove from the tree, it contains pci_find_device, it is 
unmaintained and broken for a long time. Noone uses it.

Generated in 2.6.13-mm2 kernel version. [Applicable also on 2.6.13-git10]

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 Documentation/stallion.txt       |  392 --
 Documentation/00-INDEX         |    2
 Documentation/devices.txt      |   31
 Documentation/magic-number.txt |    5
 drivers/char/Kconfig           |   22
 drivers/char/Makefile          |    2
 drivers/char/istallion.c         | 5275 
---------------------------------------
 drivers/char/stallion.c          | 5197 
--------------------------------------
 include/linux/istallion.h        |  132
 include/linux/stallion.h         |  154 -
 10 files changed, 11212 deletions(-)

Patch is here for its size (300 KiB):
http://www.fi.muni.cz/~xslaby/lnx/stallion.txt

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

