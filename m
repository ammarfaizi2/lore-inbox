Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265033AbRFZQs1>; Tue, 26 Jun 2001 12:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265038AbRFZQsS>; Tue, 26 Jun 2001 12:48:18 -0400
Received: from isdn364.s.netic.de ([212.9.163.108]:2308 "EHLO solfire")
	by vger.kernel.org with ESMTP id <S265033AbRFZQsM>;
	Tue, 26 Jun 2001 12:48:12 -0400
To: alan@lxorguk.ukuu.org.uk
Cc: mccramer@s.netic.de, linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.4.5ac1[78]
From: Meino Christian Cramer <mccramer@s.netic.de>
In-Reply-To: <E15EuO6-0003dz-00@the-village.bc.nu>
In-Reply-To: <20010626161854G.mccramer@s.netic.de>
	<E15EuO6-0003dz-00@the-village.bc.nu>
X-Mailer: Mew version 1.94.2 on XEmacs 21.4 (Academic Rigor)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010626184546H.mccramer@s.netic.de>
Date: Tue, 26 Jun 2001 18:45:46 +0200
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problems with 2.4.5ac1[78]
Date: Tue, 26 Jun 2001 16:04:22 +0100 (BST)
Message-ID: <E15EuO6-0003dz-00@the-village.bc.nu>


Thanks a lot, Alan ! :o)

That's it! My build-script only did a make dep _clean_ bzImage modules
modules_install.
With a make distclean before all runs smooth...

  keep hacking on the right site of life ! :-)
  Meino  

> >  I tried to compile linux-2.4.5ac17 with processor type "Athlon"
> >  settings.
> > 
> >  Compilation/Install was successful. But boot produces dozens of
> >  "unresolved symbols" if trying to insmod any of the modules.
> > 
> >  Not one module was insmodded successfully.
> 
> Sounds like your build wasnt clean. Save your .config file and make distclean
> is sometimes needed when changing SMP or CPU types - yes its a bug in the
> config setup really
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

