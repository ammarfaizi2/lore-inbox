Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273176AbRIPII5>; Sun, 16 Sep 2001 04:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273174AbRIPIIr>; Sun, 16 Sep 2001 04:08:47 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:20746 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S273176AbRIPIIe>;
	Sun, 16 Sep 2001 04:08:34 -0400
Date: Sun, 16 Sep 2001 10:08:34 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Steffen Persvold <sp@scali.no>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
        VDA@port.imtp.ilyichevsk.odessa.ua, alan@lxorguk.ukuu.org.uk
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
Message-ID: <20010916100834.A590@gondor.com>
In-Reply-To: <1292125035.20010914214303@port.imtp.ilyichevsk.odessa.ua> <E15i2Bp-00017m-00@the-village.bc.nu> <20010916035207.C7542@ppc.vc.cvut.cz> <3BA4530D.A3378F41@scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA4530D.A3378F41@scali.no>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 09:21:49AM +0200, Steffen Persvold wrote:
> I also have a question; if "movntq; sfence" type of memory copy can cause data
> corruption in kernel space, it can in theory also do so in user space right ?
> So, if I'm right this bug could also be on machines running a 2.2 kernel with
> userspace programs using 3DNow (or SSE even) instructions.

Sure. I did crash a computer running an old kernel (not 2.2 but 
2.4.0-testX without the optimised fast_copy_page) from a non-privileged
user space program containing the same code as the optimised fast_copy_page.

Jan

