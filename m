Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbRAaLTk>; Wed, 31 Jan 2001 06:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130926AbRAaLTa>; Wed, 31 Jan 2001 06:19:30 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:64777 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130105AbRAaLT2>;
	Wed, 31 Jan 2001 06:19:28 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 31 Jan 2001 12:17:55 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Matrox G450 problems with 2.4.0 and xfree
CC: <linux-kernel@vger.kernel.org>, marcel@mesa.nl
X-mailer: Pegasus Mail v3.40
Message-ID: <142368953925@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 01 at 8:44, David Woodhouse wrote:
> On Tue, 30 Jan 2001, Marcel J.E. Mol wrote:
> 
> > Installed a Matrox G450 on my linux system. Now it has problems
> > booting.
> > 
> > Previously I had a matrox G400 card and that worked without any problems.
> > 
> > Below follows .config for the 2.4.0 kernel.
> > 
> > # CONFIG_FB_MATROX_G450 is not set

It is only for secondary head support - and all code which is guarded
by this define is executed after lockup occurs, so no, it is not the 
reason why it works / does not work...

If it helped you, I think that rule (4) from my another posting
applies to you - you are just lucky...

I asked matrox devrel again, but no answer. And linking matroxfb with 
512KB binary-only mgaHALlib.a is unacceptable personally for me, not
even talking about license issues... (and not talking about technical
problems with getting mgaHALlib to work in kernel environment...)
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
