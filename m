Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277746AbRJMER1>; Sat, 13 Oct 2001 00:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278264AbRJMERI>; Sat, 13 Oct 2001 00:17:08 -0400
Received: from mnh-1-13.mv.com ([207.22.10.45]:39951 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S277746AbRJMERF>;
	Sat, 13 Oct 2001 00:17:05 -0400
Message-Id: <200110130535.AAA06137@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.49-2.4.12
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Oct 2001 00:35:42 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.12 is available.

The highlights:

Redid the signal delivery code so that it is possible to write-protect physical
memory from userspace.  This turns out to be expensive, so this version of
UML is noticably slower than previous ones.  Memory protection will be made
optional until I can get some support from the host kernel for doing it
more quickly.

An ancient crash in the console driver has been fixed.  This was easiest to
see when booting a distro, such as SuSE, that doesn't put a getty on the main 
console.

CONFIG_DEBUG_SLAB is now available in the configuration.

uml_router is now known as uml_switch.  It now has a -hub option.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://user-mode-linux.sourceforge.net/dl-sf.html

				Jeff

