Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262543AbRE3BOA>; Tue, 29 May 2001 21:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262545AbRE3BNu>; Tue, 29 May 2001 21:13:50 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39917 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262543AbRE3BNq>;
	Tue, 29 May 2001 21:13:46 -0400
Message-ID: <3B14493E.63F861E7@mandrakesoft.com>
Date: Tue, 29 May 2001 21:13:34 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
Cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, tori@unhappy.mine.nu,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net #9
In-Reply-To: <200105300048.CAA04583@green.mif.pg.gda.pl> <20010529180420.A14639@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 
> On Wed, May 30, 2001 at 02:48:24AM +0200, Andrzej Krzysztofowicz wrote:
> >
> > The following patch removes some zero initializers from statics
> >
> > Andrzej
> 
>         If I were you, I would fix gcc rather than making my code
> unreadable.
[...]
>         Therefore, Alan, please do not apply those kind of patches to
> my drivers.

This is standard kernel cleanup that makes the resulting image smaller. 
These patches have been going into all areas of the kernel for quite
some time.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
