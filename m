Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265534AbSJXQdL>; Thu, 24 Oct 2002 12:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265535AbSJXQdL>; Thu, 24 Oct 2002 12:33:11 -0400
Received: from mail.hometree.net ([212.34.181.120]:65493 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265534AbSJXQdL>; Thu, 24 Oct 2002 12:33:11 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: One for the Security Guru's
Date: Thu, 24 Oct 2002 16:39:23 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <ap97nr$h6e$1@forge.intermeta.de>
References: <1035453664.1035.11.camel@syntax.dstl.gov.uk> <Pine.LNX.4.44.0210241209250.648-100000@innerfire.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1035477563 32382 212.34.181.4 (24 Oct 2002 16:39:23 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 24 Oct 2002 16:39:23 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack <gmack@innerfire.net> writes:

>It gets even worse if almost all of your services are encrypted(like you
>would find on an e-commerse site).  https will blind an IDS.  The last
>place I worked only had 3 ports open and 2 of them were encrypted.

Nah. Do it right:

Internet ----- Firewall ---- SSL Accelerator Box --+---- Webserver
         HTTPS          HTTPS                      | HTTP
                                                   |
                                                  IDS

Check out the boxes from SonicWall, they're quite nice. Expensive,
though. If your E-Commerce site can't afford them, well, then they
shouldn't be able to affore a security consulant in the first
place. :-)

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
