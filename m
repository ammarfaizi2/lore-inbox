Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319106AbSIDJDe>; Wed, 4 Sep 2002 05:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319107AbSIDJDd>; Wed, 4 Sep 2002 05:03:33 -0400
Received: from mail.hometree.net ([212.34.181.120]:5077 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S319106AbSIDJDd>; Wed, 4 Sep 2002 05:03:33 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: X.25 Support in Kernel?
Date: Wed, 4 Sep 2002 09:08:06 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <al4ihm$h34$1@forge.intermeta.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1031130486 27123 212.34.181.4 (4 Sep 2002 09:08:06 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 4 Sep 2002 09:08:06 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after quite an extensive search about X.25 support for linux (yes,
I've seen the pages of linux-sna and the linux-x25 mailing list on
vger):

- Is there anything resembling working X.25 over LLC.2 support in the 2.4
  kernel?

- Is there more that the XOP stuff from Stephane Fillod which seems to
  be 2 1/2 years old for User space X.25 over TCP?

- Is there still work on this? Henner Eisen maintains it (according to the 
  MAINTAINERS file), but the number of messages on linux-x25 seems to be
  low.

Basically I need to talk to a Cisco router with X.25 protocol and be
able to terminate an X.25 connection in user space in an
application. As far as I can see, there is the easy way talking XOP
with the router or talking X.25 over LLC2 (which Cisco calls CMNS) for
which support seems to be "not yet completely functional".

Considering the possibility of hacking with the x.25 part of the kernel;
which would be the best way to start with LLC2 support? Using the driver
from linux-sna or hacking with net/llc ?

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
