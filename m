Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbUAYPac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 10:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUAYPac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 10:30:32 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:22793 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264368AbUAYPa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 10:30:27 -0500
Date: Sun, 25 Jan 2004 16:36:10 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Marco Rebsamen <mrebsamen@swissonline.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: Troubles Compiling 2.6.1 on SuSE 9
Message-ID: <20040125153610.GA3123@mars.ravnborg.org>
Mail-Followup-To: Marco Rebsamen <mrebsamen@swissonline.ch>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <200401242137.34881.mrebsamen@swissonline.ch> <20040125124557.GA2036@mars.ravnborg.org> <200401251427.02975.mrebsamen@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200401251427.02975.mrebsamen@swissonline.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> arch/i386/boot/compressed/vmlinux.bin
> Ungültiger Maschinenbefehl (in english, invalid machinecommand i guess)

Either objcopy is missing or the executable is damaged.
try 'which objcopy'

>From my suse 9.0 box:

sam@mars:~> which objcopy
/usr/bin/objcopy
sam@mars:~> ll /usr/bin/objcopy
-rwxr-xr-x    1 root     root       248064 2003-09-23 17:34 /usr/bin/objcopy
sam@mars:~> md5sum /usr/bin/objcopy
4aa1f3b8bc18dfdfdd7ae733804b0f1c  /usr/bin/objcopy

IIRC objcopy is part of binutils - which I may have installed by hand
after normal installation.

	Sam
