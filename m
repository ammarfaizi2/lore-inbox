Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276302AbRJKN0D>; Thu, 11 Oct 2001 09:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276335AbRJKNZx>; Thu, 11 Oct 2001 09:25:53 -0400
Received: from web20510.mail.yahoo.com ([216.136.226.145]:271 "HELO
	web20510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276305AbRJKNZi>; Thu, 11 Oct 2001 09:25:38 -0400
Message-ID: <20011011132609.32653.qmail@web20510.mail.yahoo.com>
Date: Thu, 11 Oct 2001 15:26:09 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Linux-2.4.10-ac11
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I also _think_ nothing else needs the include in
<asm-i386/keyboard.h> so kill that off too.

indeed, there are some files which need it and don't
compile
anymore. You have to leave the include enabled in
keyboard.h :

- arch/i386/kernel/dmi_scan.c
- drivers/char/keyboard.c
- potentially other files in drivers/char/

Regards,
Willy


___________________________________________________________
Un nouveau Nokia Game commence. 
Allez sur http://fr.yahoo.com/nokiagame avant le 3 novembre
pour participer à cette aventure tous médias.
