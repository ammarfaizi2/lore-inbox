Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129146AbRBDNri>; Sun, 4 Feb 2001 08:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130764AbRBDNr1>; Sun, 4 Feb 2001 08:47:27 -0500
Received: from smtp-rt-1.wanadoo.fr ([193.252.19.151]:26101 "EHLO
	anagyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129146AbRBDNrI>; Sun, 4 Feb 2001 08:47:08 -0500
Message-ID: <3A7D5CFB.1C21ECD2@wanadoo.fr>
Date: Sun, 04 Feb 2001 14:45:31 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierfrancesco Caci <p.caci@tin.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 segfault when doing "ls /dev/"
In-Reply-To: <87u26avkfp.fsf@penny.ik5pvx.ampr.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierfrancesco Caci wrote:

>    48 ?        S      0:00 /sbin/devfsd /dev

on my box devfsd has pid 15, it comes just after the [kdaems]

    1 ?        S      0:04 init
    2 ?        SW     0:00 [keventd]
    3 ?        SW     0:00 [kapm-idled]
    4 ?        SW     0:00 [kswapd]
    5 ?        SW     0:00 [kreclaimd]
    6 ?        SW     0:00 [bdflush]
    7 ?        SW     0:00 [kupdate]
    8 ?        SW     0:00 [kreiserfsd]
   15 ?        S      0:00 devfsd /dev

and it works with 2.4.x

-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
