Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbTAQEDa>; Thu, 16 Jan 2003 23:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267282AbTAQEDa>; Thu, 16 Jan 2003 23:03:30 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:40866 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267255AbTAQED3>; Thu, 16 Jan 2003 23:03:29 -0500
Date: Thu, 16 Jan 2003 22:12:23 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Carl Gherardi <C.Gherardi@curtin.edu.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.5.59
In-Reply-To: <8B67F2E2D93ED5118D6E00508BB8D127011C3ED0@exmsb04.curtin.edu.au>
Message-ID: <Pine.LNX.4.44.0301162211410.19302-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Carl Gherardi wrote:

> Just done a bk pull and got this
> 
> # make mrproper; make menuconfig
> ....
> gcc  -o scripts/lxdialog/lxdialog scripts/lxdialog/checklist.o
> scripts/lxdialog/menubox.o scripts/lxdialog/textbox.o
> scripts/lxdialog/yesno.o scripts/lxdialog/inputbox.o scripts/lxdialog/util.o
> scripts/lxdialog/lxdialog.o scripts/lxdialog/msgbox.o -lncurses
> ./scripts/kconfig/mconf arch/i386/Kconfig
> arch/i386/Kconfig:1185: can't open file "drivers/eisa/Kconfig"
> make: *** [menuconfig] Error 1

	bk -r get -q

or just

	bk get drivers/eisa

in this case. I guess this is becoming a FAQ.

--Kai


