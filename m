Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264566AbUAYRXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 12:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbUAYRXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 12:23:25 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:63897 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S264566AbUAYRXY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 12:23:24 -0500
From: Marco Rebsamen <mrebsamen@swissonline.ch>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Troubles Compiling 2.6.1 on SuSE 9
Date: Sun, 25 Jan 2004 18:27:23 +0100
User-Agent: KMail/1.5.4
References: <200401242137.34881.mrebsamen@swissonline.ch> <200401251427.02975.mrebsamen@swissonline.ch> <20040125153610.GA3123@mars.ravnborg.org>
In-Reply-To: <20040125153610.GA3123@mars.ravnborg.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401251827.23510.mrebsamen@swissonline.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 25. Januar 2004 16:36 schrieben Sie:
> > arch/i386/boot/compressed/vmlinux.bin
> > Ungültiger Maschinenbefehl (in english, invalid machinecommand i guess)
>
> Either objcopy is missing or the executable is damaged.
> try 'which objcopy'
>
> From my suse 9.0 box:
>
> sam@mars:~> which objcopy
> /usr/bin/objcopy
> sam@mars:~> ll /usr/bin/objcopy
> -rwxr-xr-x    1 root     root       248064 2003-09-23 17:34
> /usr/bin/objcopy sam@mars:~> md5sum /usr/bin/objcopy
> 4aa1f3b8bc18dfdfdd7ae733804b0f1c  /usr/bin/objcopy
>
> IIRC objcopy is part of binutils - which I may have installed by hand
> after normal installation.
>
> 	Sam


that was it.... the MD5 sum was something like 2.... so i reinstalled binutils 
and it worked.... but now i got problems (like everytime) with the modules.
I get many messages:
modprobe: modprobe: Can't open dependencies file /lib/
modules/2.4.21-99-default/modules.dep (no such file or dir.)

i did make modules_install. Where's my fault ?

thanks very much for the help....

