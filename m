Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267157AbSKTAUV>; Tue, 19 Nov 2002 19:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267165AbSKTAUV>; Tue, 19 Nov 2002 19:20:21 -0500
Received: from guru.webcon.net ([66.11.168.140]:17857 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S267157AbSKTAUU>;
	Tue, 19 Nov 2002 19:20:20 -0500
Date: Tue, 19 Nov 2002 19:27:20 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Build error (devlist.h) in 2.4.20-rc2-ac1
Message-ID: <Pine.LNX.4.44.0211191903460.2942-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still getting this (same as -rc1-ac4):

make[3]: Entering directory
`/usr/src/linux-2.4.20-rc2-ac1+fs199+acpi20021118/drivers/pci'
make[3]: *** No rule to make target
`/usr/src/linux-2.4.20-rc2-ac1+fs199+acpi20021118/drivers/pci/devlist.h',
needed by `names.o'.  Stop.
make[3]: Leaving directory
`/usr/src/linux-2.4.20-rc2-ac1+fs199+acpi20021118/drivers/pci'
make[2]: *** [first_rule] Error 2

Yet if I go into drivers/pci, 'make devlist.h' works fine, then the build
continues fine (names.o no longer complains because devlist.h is build). I
can't figure out what's wrong with the Makefile.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan@webcon.ca          PGP: #2DA40D07           www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------


