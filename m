Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316863AbSFDWSa>; Tue, 4 Jun 2002 18:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSFDWS3>; Tue, 4 Jun 2002 18:18:29 -0400
Received: from mallaury.noc.nerim.net ([62.4.17.82]:42505 "HELO
	mallaury.noc.nerim.net") by vger.kernel.org with SMTP
	id <S316863AbSFDWS1>; Tue, 4 Jun 2002 18:18:27 -0400
Message-ID: <3CFD3CB3.5030409@free.fr>
Date: Wed, 05 Jun 2002 00:18:27 +0200
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniela Engert <dani@ngrt.de>, linux-kernel@vger.kernel.org
Cc: Ollie Lho <ollie@sis.com.tw>
Subject: SIS645DX ATA/133
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Just for reference: my machine at home has a SiS645DX (ATA/133) plus a
 > Promise PDC20268 (ATA/100). The latest SUSE distribution (2.4.18 based)
 > falls flat on its face, the IDE drivers fail to handle both IDE
 > controllers.
 >
 > Andre's patches supposedly fix the Promise issue, but the SiS problem
 > is still unresolved in Linux.
 >
 > Ciao,
 >   Dani
 >

Lately I spent a couple of hours through the info I've at hand 
concerning the 645DX ATA/133 support.
My problem lies in the original 645 (only ATA/100 capable) versus the 645DX.
I should have no problem coding support for each one. In fact the 
original 645 should already be supported (I says "should" as I've no 
success reports, people tends to write reports when there is a failure 
:-). The problem is I don't yet know how to differentiate them. So I 
can't support both of them in the same driver and this is a show stopper 
for me.
If anyone on the list knows how to make the difference, please mail me 
the info.

A complete lspci -vxxx from both a 645 and a 645DX might help if the 
difference lies in the config registers but I'm unsure.

LB.

