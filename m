Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTKOS5d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 13:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTKOS5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 13:57:33 -0500
Received: from mail.gmx.de ([213.165.64.20]:27065 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261931AbTKOS5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 13:57:32 -0500
X-Authenticated: #7682112
From: Nils Neumann <nilsn@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Instability/Crash with Promise Controller and Athlon Powersaving
Date: Sat, 15 Nov 2003 19:57:29 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311151957.29465.nilsn@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello developer,

I don't know what it is, but it seems to be a bug in the promise code.

3 Test Computer

First : 
ECS K7VTA3 Bios 5.0c (newest), Promise PDC20268, Athlon 1800+, kernel 2.4.21 / 
2.4.22 / 2.4.23-rc1 / OS debian stable
Second :
EPOX, Promise PDC20262, Athlon 2600+ kernel 2.6.0test9 / OS gentoo
Third : 
ECS K7VZA3, Promise PDC20268, Duron 1333 (later : Duron 800), kernel 2.4.21 / 
2.4.22 / OS debian testing

Always the same ...
Everything works perfect, but when I enable the STPGNT-Mode (Stop Grant Mode) 
(-> http://www.daniel.nofftz.net/linux/) I get one problem : Writing (large 
files) to a disc on the promise controller. The speed is very slow, or the 
computer hangs after transfering 70-100 Mbyte, but some minutes later it 
works for the next 100 Mbyte. Sometimes the machine totally crashs, but I 
don't get any error messages. Everything else working perfect!!
I have only permanent access to the first configuration if there are 
questions. 

Thanks for help,
Nils 
(please : CC : kernel@knabber.homelinux.net)

