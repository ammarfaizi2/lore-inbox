Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSF1LUc>; Fri, 28 Jun 2002 07:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSF1LUb>; Fri, 28 Jun 2002 07:20:31 -0400
Received: from smtp.compuserve.de ([62.52.27.101]:24823 "HELO
	desws061.mediaways.net") by vger.kernel.org with SMTP
	id <S317117AbSF1LUa>; Fri, 28 Jun 2002 07:20:30 -0400
Message-ID: <001501c21e96$2096b2f0$1601a8c0@surfstation>
From: "Uwe Ziegler" <aquahasi@compuserve.de>
To: <linux-kernel@vger.kernel.org>
Subject: Problem: SCSI (initio 9100u) and kernel 2.5.24
Date: Fri, 28 Jun 2002 13:22:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i tried to compile the new 2.5.24 kernel with modular scsi-support for
initio 9100u on my suse 7.3 system
with a standard ftp-update from suse, too.(don´t beat - lfs comes with dsl
;-)
i didn´t found a notice in kernel.org related sites about this behaviour.
compiling stops with the following messages:

......
# ini9100u.c : 111 : # error Please convert me to
Documentation/DMA-mapping.txt
# ini9100u.c : In funktion ´i91uBuildSCB` :
# ini9100u.c : 494 : structure has no member named ´address`
# ini9100u.c : 503 : structure has no member named ´address`
.......

sorry, i´m a stupid beginner, but if my brain doesn´t suck me, it looks more
like a missing declaration, then
a missing bracked. The whole file contains the variable "address" only 2x,
just in the lines described above.
Or does "address" come from the environment?
This problem is too difficult for me, but i´m intrested in the solution,
when this message becomes a tread.

thx
uwe ziegler

May the brain be with you
and good ideas - forever!


