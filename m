Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTLLVbt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTLLVbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:31:49 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35535 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262038AbTLLVbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:31:45 -0500
Date: Fri, 12 Dec 2003 22:31:37 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.24-pre1: ask for CONFIG_INDYDOG only on mips
Message-ID: <20031212213137.GE1825@fs.tum.de>
References: <Pine.LNX.4.44.0312101417080.1546-100000@logos.cnet> <20031210204628.GA9103@fs.tum.de> <20031211225819.GA20373@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211225819.GA20373@linux-mips.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 11:58:19PM +0100, Ralf Baechle wrote:
> On Wed, Dec 10, 2003 at 09:46:28PM +0100, Adrian Bunk wrote:
> 
> > A dependency on a possibly undefined variable doesn't work with the 2.4 
> > config system, and "make oldconfig" asks me on i386 for CONFIG_INDYDOG.
> 
> Applied - I hpe that's that last one of this kind lurking somewhere ...

Thanks.

Was the removal of the i386 Mwave support option in the same patch an 
accident that should be reverted, or was there a reason for it?

>   Ralf

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

