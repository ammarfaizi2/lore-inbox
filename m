Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266251AbRF3Se3>; Sat, 30 Jun 2001 14:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266248AbRF3SeT>; Sat, 30 Jun 2001 14:34:19 -0400
Received: from smtp6vepub.gte.net ([206.46.170.27]:24118 "EHLO
	smtp6ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S266249AbRF3SeF>; Sat, 30 Jun 2001 14:34:05 -0400
Message-ID: <3B3E1B93.B0D21DC6@neuronet.pitt.edu>
Date: Sat, 30 Jun 2001 14:33:55 -0400
From: Rafael Herrera <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bernfried Molte <bbm@studioorange.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6-pre8 build error of aic7xxxt
In-Reply-To: <E15GPL3-0002FV-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > gcc -I/usr/include -I. -ldb aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c -o aicasm
> > > /usr/i486-linux/bin/ld: cannot open -ldb: No such file or directory
> > > collect2: ld returned 1 exit status
> > > make[5]: *** [aicasm] Error 1
> > > [...]
> > > ----------------------------------------------------------------------
> >
> > may be a 'make mrproper' solves your problem,
> 
> Unlikely since the problem is the fact that the scsi firmware assembler wants
> a library that isnt installed.

It is not necessary to re-build the firmware (according to Justin).
Disable that option and try to rebuild again.

-- 
     Rafael
