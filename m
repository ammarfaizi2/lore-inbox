Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131004AbRCJKZM>; Sat, 10 Mar 2001 05:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131009AbRCJKZC>; Sat, 10 Mar 2001 05:25:02 -0500
Received: from ulima.unil.ch ([130.223.144.143]:50701 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S131004AbRCJKYt>;
	Sat, 10 Mar 2001 05:24:49 -0500
Date: Sat, 10 Mar 2001 11:24:06 +0100
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.2-ac1[67] aicam compil error
Message-ID: <20010310112406.B20382@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010310002640.A13924@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010310002640.A13924@ulima.unil.ch>; from greg@ulima.unil.ch on Sat, Mar 10, 2001 at 12:26:40AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake FAVRE Gregoire (greg@ulima.unil.ch):

> Sorry if that has already been posted, I read the m-l via newsgroups.
> When I try to compile, I got:
> `/usr/src/linux-2.4.2-ac17/drivers/scsi/aic7xxx/aicasm'
> kgcc -I/usr/include -ldb aicasm_gram.c aicasm_scan.c aicasm.c
> aicasm_symbol.c -o aicasm
> aicasm/aicasm_gram.y:45: ../queue.h: No such file or directory
> ...
> aicasm/aicasm_scan.l:51: y.tab.h: No such file or directory
> make[5]: *** [aicasm] Error 1
> ...
> Exit 2

Hum... I have done a rpm -qa|grep -i db and found that I still have
BerkeleyDB-2.7.7-5mdk BerkeleyDB-devel-2.7.7-5mdk and also
db3-3.1.14-2mdk and db3-devel-3.1.14-2mdk, so I did a rpm -e
BerkeleyDB-2.7.7-5mdk BerkeleyDB-devel-2.7.7-5mdk

and compiled 2.4.2-ac17 with no problem at all ;-)

Sorry for the post,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
