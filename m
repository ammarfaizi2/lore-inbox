Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261190AbREUSkQ>; Mon, 21 May 2001 14:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbREUSkG>; Mon, 21 May 2001 14:40:06 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:6119 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S261190AbREUSju>;
	Mon, 21 May 2001 14:39:50 -0400
Message-ID: <3B0960EA.F3465948@mandrakesoft.com>
Date: Mon, 21 May 2001 14:39:38 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, rth@twiddle.net
Subject: Re: Compile fails an Alpha: include/asm/pci.h included from 
 arch/alpha/kernel/setup.c
In-Reply-To: <20010521171854.A4121@lug-owl.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> 
> Hi!
> 
> Kernel 2.4.5-pre[34] don't compile on Alpha:
> 
> In incluse/asm-alpha/pci.h (include during compile of
> arch/alpha/kernel/setup.c), there is

include linux/pci.h not asm/pci.h...   I've got a fix patch going to
Linus today, along with some other small Alpha build fixes like this.

-- 
Jeff Garzik      | "Are you the police?"
Building 1024    | "No, ma'am.  We're musicians."
MandrakeSoft     |
