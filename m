Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271747AbRIVQBd>; Sat, 22 Sep 2001 12:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271719AbRIVQBP>; Sat, 22 Sep 2001 12:01:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39948 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271712AbRIVQBB>; Sat, 22 Sep 2001 12:01:01 -0400
Subject: Re: Tainting kernels for non-GPL or forced modules
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 22 Sep 2001 17:05:52 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <27975.1001164529@ocs3.intra.ocs.com.au> from "Keith Owens" at Sep 22, 2001 11:15:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kpHs-0003a7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What to do about modules with no license?  Complain and taint or
> silently ignore?  A lot of modules in -ac14 have no MODULE_LICENSE,
> probably because they have no MODULE_AUTHOR.  IMHO the default should
> be complain and taint, even though it will generate lots of newbie
> questions to l-k.

I still have many to do. What would help me no end would be a version of
depmod or similar which warned about modules with 

o	No description
o	No author
o	No license tag

Then we can stage a concerted clean up run

Alan
