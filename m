Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSGINLN>; Tue, 9 Jul 2002 09:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSGINKa>; Tue, 9 Jul 2002 09:10:30 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:26347 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S315245AbSGINJD>; Tue, 9 Jul 2002 09:09:03 -0400
Date: Tue, 9 Jul 2002 05:03:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Alvord <jalvo@mbay.net>, Thunder from the hill <thunder@ngforever.de>,
       Pablo Fischer <exilion@yifan.net>, Mark Hahn <hahn@physics.mcmaster.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: StackPages errors (CALLTRACE)
Message-ID: <20020709030259.GA113@elf.ucw.cz>
References: <83ubiu433pkcf41ev9ihl7mgo0tn1kokcc@4ax.com> <E17QaN6-0004Ci-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17QaN6-0004Ci-00@the-village.bc.nu>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There has also been a patch on L-K which implments CMOV on prior-PPro
> > processors. john
> 
> It has a hideous overhead. Just dont use cmov blindly in kernels. The kernel 
> stuff will take care not to let the compiler stick cmov instructions into
> a non ppro+ kernel

Not only nasty overhead but potential nasty implications. You get
exception where you'd normaly get simple instruction. Do NOT use cmov
emulation for kernel.
									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
