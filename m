Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130777AbRCJAfV>; Fri, 9 Mar 2001 19:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130781AbRCJAfL>; Fri, 9 Mar 2001 19:35:11 -0500
Received: from ulima.unil.ch ([130.223.144.143]:41741 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S130777AbRCJAfA>;
	Fri, 9 Mar 2001 19:35:00 -0500
Date: Sat, 10 Mar 2001 01:34:15 +0100
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: Nathan Dabney <smurf@osdlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aicasm db3 fiasco
Message-ID: <20010310013415.B14199@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	Nathan Dabney <smurf@osdlab.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010309160145.H30901@osdlab.org> <20010310012647.A14199@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010310012647.A14199@ulima.unil.ch>; from greg@ulima.unil.ch on Sat, Mar 10, 2001 at 01:26:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake FAVRE Gregoire (greg@ulima.unil.ch):

> The files exist but aren't seen??? I have tried to change the path to
> them, that don't change anything???

If I put absolut path, that go further...
 
> I don't understand why...

But:

make[4]: Entering directory
`/usr/src/linux-2.4.2-ac17/drivers/scsi/aic7xxx'
yacc  aicasm/aicasm_gram.y 
mv -f y.tab.c aicasm/aicasm_gram.c
lex  -t aicasm/aicasm_scan.l > aicasm/aicasm_scan.c
make -C aicasm
make[5]: Entering directory
`/usr/src/linux-2.4.2-ac17/drivers/scsi/aic7xxx/aicasm'
kgcc -I/usr/include -ldb aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c -o aicasm
/home/greg/tmp/ccM7IZO2.o: In function `symtable_open':
/home/greg/tmp/ccM7IZO2.o(.text+0x1b5): undefined reference to
`__db185_open'
collect2: ld returned 1 exit status
make[5]: *** [aicasm] Error 1
make[5]: Leaving directory
`/usr/src/linux-2.4.2-ac17/drivers/scsi/aic7xxx/aicasm'
make[4]: *** [aicasm/aicasm] Error 2
make[4]: Leaving directory
`/usr/src/linux-2.4.2-ac17/drivers/scsi/aic7xxx'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory
`/usr/src/linux-2.4.2-ac17/drivers/scsi/aic7xxx'
make[2]: *** [_subdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.2-ac17/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.2-ac17/drivers'
make: *** [_dir_drivers] Error 2

I give out...

Thanks you very much,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
