Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130775AbRCJA1w>; Fri, 9 Mar 2001 19:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130776AbRCJA1l>; Fri, 9 Mar 2001 19:27:41 -0500
Received: from ulima.unil.ch ([130.223.144.143]:41229 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S130775AbRCJA1c>;
	Fri, 9 Mar 2001 19:27:32 -0500
Date: Sat, 10 Mar 2001 01:26:47 +0100
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: Nathan Dabney <smurf@osdlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aicasm db3 fiasco
Message-ID: <20010310012647.A14199@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	Nathan Dabney <smurf@osdlab.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010309160145.H30901@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010309160145.H30901@osdlab.org>; from smurf@osdlab.org on Fri, Mar 09, 2001 at 04:01:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Nathan Dabney (smurf@osdlab.org):

> Debian does not use db3 at all, yet.
> 
> Applies against 2.4.2-ac17

Hello,

thanks for your answer, I cannot apply your patch, don't know why, but
readind it I think it won't change anything for me: I have db3 (I have a
Mandrake...).

>From my compilation:
make[5]: Entering directory
`/usr/src/linux-2.4.2-ac17/drivers/scsi/aic7xxx/aicasm'
kgcc -I/usr/include -ldb aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c -o aicasm
aicasm/aicasm_gram.y:45: ../queue.h: No such file or directory
aicasm/aicasm_gram.y:50: aicasm.h: No such file or directory
aicasm/aicasm_gram.y:51: aicasm_symbol.h: No such file or directory
aicasm/aicasm_gram.y:52: aicasm_insformat.h: No such file or directory
aicasm/aicasm_scan.l:44: ../queue.h: No such file or directory
aicasm/aicasm_scan.l:49: aicasm.h: No such file or directory
aicasm/aicasm_scan.l:50: aicasm_symbol.h: No such file or directory
aicasm/aicasm_scan.l:51: y.tab.h: No such file or directory

The files exist but aren't seen??? I have tried to change the path to
them, that don't change anything???

I don't understand why...

Thanks you very much,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
