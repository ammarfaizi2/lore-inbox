Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbUAYNXJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 08:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUAYNXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 08:23:09 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:64902 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S264267AbUAYNXG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 08:23:06 -0500
From: Marco Rebsamen <mrebsamen@swissonline.ch>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Troubles Compiling 2.6.1 on SuSE 9
Date: Sun, 25 Jan 2004 14:27:02 +0100
User-Agent: KMail/1.5.4
References: <200401242137.34881.mrebsamen@swissonline.ch> <20040125124557.GA2036@mars.ravnborg.org>
In-Reply-To: <20040125124557.GA2036@mars.ravnborg.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401251427.02975.mrebsamen@swissonline.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 25. Januar 2004 13:45 schrieben Sie:
> On Sat, Jan 24, 2004 at 09:37:34PM +0100, Marco Rebsamen wrote:
> > I try to compile my own kernel with 2.6.1 on suse 9. But i always get the
> > same error. i applied the patch 2.6.2-rc1 but wasn't helping.
> >   objcopy -O binary -R .note -R .comment -S  vmlinux arch/i386/boot/
> > compressed/vmlinux.bin
> > make[2]: *** [arch/i386/boot/compressed/vmlinux.bin] Fehler 132
>
> Looks like objcopy is failing.
> Could you try to run the above command by hand in the top-level
> directory of your kernel tree.
> If it still fails try with
> LANG=C LC_ALL=C objcopy ....
>
> Just to check that language does not have any effect here.
> I doubt so, but worth the try.
>
> I browsed the objcopy src (a random version found by google)
> without seeing where it could return 132
>
> 	Sam

thanks for the help....

here my output...

bineo:/usr/src/linux-2.6.1 # objcopy -O binary -R .note -R .comment -S vmlinux 
arch/i386/boot/compressed/vmlinux.bin
Ungültiger Maschinenbefehl (in english, invalid machinecommand i guess)

bineo:/usr/src/linux-2.6.1 # LANG=C LC_ALL=C objcopy -O binary -R .note 
-R .comment -S vmlinux arch/i386/boot/compressed/vmlinux.bin
Ungültiger Maschinenbefehl

