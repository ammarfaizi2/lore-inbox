Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSLOP3O>; Sun, 15 Dec 2002 10:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSLOP3O>; Sun, 15 Dec 2002 10:29:14 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:59612 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261836AbSLOP3O>;
	Sun, 15 Dec 2002 10:29:14 -0500
Date: Sun, 15 Dec 2002 16:37:07 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212151537.QAA23212@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, m.c.p@wolk-project.de
Subject: Re: 2.4.21-pre1 broke the ide-tape driver
Cc: marcelo@connectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Dec 2002 02:23:34 +0100, Marc-Christian Petersen wrote:
>> Kernel 2.4.21-pre1 broke the ide-tape driver: the driver
>> now hangs during initialisation. 2.2 kernels (with Andre's
>> IDE patch) and 2.4 up to 2.4.20 do not have this problem.
>> My box has a Seagate STT8000A ATAPI tape drive as hdd;
>> hdc is a Philips CD-RW, and the controller is ICH2 (i850 chipset).
>http://linux.bkbits.net:8080/linux-2.4/patch@1.828?nav=index.html|ChangeSet@-7d|cset@1.828

That fixed it. Thanks.

/Mikael
