Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbTAQEOC>; Thu, 16 Jan 2003 23:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267349AbTAQEOC>; Thu, 16 Jan 2003 23:14:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44550 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267348AbTAQEOA>;
	Thu, 16 Jan 2003 23:14:00 -0500
Message-ID: <3E2784E4.904@pobox.com>
Date: Thu, 16 Jan 2003 23:21:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl Gherardi <C.Gherardi@curtin.edu.au>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
References: <8B67F2E2D93ED5118D6E00508BB8D127011C3ED0@exmsb04.curtin.edu.au>
In-Reply-To: <8B67F2E2D93ED5118D6E00508BB8D127011C3ED0@exmsb04.curtin.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl Gherardi wrote:
> Hey all,
> 
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


You need to check that file out.

After every run of "bk pull", I always do

	bk -r co -Sq

