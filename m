Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266236AbRF3SNI>; Sat, 30 Jun 2001 14:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266237AbRF3SM6>; Sat, 30 Jun 2001 14:12:58 -0400
Received: from hera.society.de ([195.227.57.7]:19717 "EHLO hera.society.de")
	by vger.kernel.org with ESMTP id <S266236AbRF3SMr>;
	Sat, 30 Jun 2001 14:12:47 -0400
Date: Sat, 30 Jun 2001 20:12:36 +0200
From: Bernfried Molte <bbm@studioorange.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6-pre8 build error of aic7xxx
Message-Id: <20010630201236.69fcdddd.bbm@studioorange.de>
In-Reply-To: <lxbsn5lwl5.fsf@pixie.isr.ist.utl.pt>
In-Reply-To: <lxbsn5lwl5.fsf@pixie.isr.ist.utl.pt>
Organization: Studioorange
X-Mailer: Sylpheed version 0.5.0pre2 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jun 2001 18:13:42 +0100
Rodrigo Ventura <yoda@isr.ist.utl.pt> wrote:

>         I got the following build error of aic7xxx drivers, with
> kernel 2.4.6-pre8:
> 
> ----------------------------------------------------------------------
> [...]
> make[2]: Entering directory `/usr/src/linux/drivers/scsi'
> make -C aic7xxx
> make[3]: Entering directory `/usr/src/linux/drivers/scsi/aic7xxx'
> make all_targets
> make[4]: Entering directory `/usr/src/linux/drivers/scsi/aic7xxx'
> make -C aicasm
> make[5]: Entering directory `/usr/src/linux/drivers/scsi/aic7xxx/aicasm'
> gcc -I/usr/include -I. -ldb aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c -o aicasm
> /usr/i486-linux/bin/ld: cannot open -ldb: No such file or directory
> collect2: ld returned 1 exit status
> make[5]: *** [aicasm] Error 1
> [...]
> ----------------------------------------------------------------------

may be a 'make mrproper' solves your problem,

bernfried molte
