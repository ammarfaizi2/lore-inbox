Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131899AbRDMWEq>; Fri, 13 Apr 2001 18:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131973AbRDMWEg>; Fri, 13 Apr 2001 18:04:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33038 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131899AbRDMWEZ>; Fri, 13 Apr 2001 18:04:25 -0400
Subject: Re: 2.4.3 and Alpha
To: sp@scali.no (Steffen Persvold)
Date: Fri, 13 Apr 2001 23:06:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AD76BA0.EF7EDE6D@scali.no> from "Steffen Persvold" at Apr 13, 2001 11:12:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14oBht-0003dd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> `pmd_alloc'
> /usr/src/redhat/linux/include/linux/mm.h:412: previous declaration of
> `pmd_alloc'
> make: *** [init/main.o] Error 1
> 
> 
> 2.4.1 compiled fine, and as far as I can see, some changes has been made
> to mm.h since then. I think these changes was followed up by i386, ppc,
> s390 and sparc64 kernels but not on others. Any plans on when this is
> done ?

Its fixed in the -ac tree but I've yet to push that set of changes to Linus
