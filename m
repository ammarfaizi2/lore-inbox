Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130417AbQKVAkF>; Tue, 21 Nov 2000 19:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131942AbQKVAjz>; Tue, 21 Nov 2000 19:39:55 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:12051 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130417AbQKVAjm>;
	Tue, 21 Nov 2000 19:39:42 -0500
Message-ID: <3A1B0EA7.FC8BF073@mandrakesoft.com>
Date: Tue, 21 Nov 2000 19:09:11 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jamagallon@able.es
CC: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
In-Reply-To: <Pine.LNX.4.21.0011211438490.756-100000@tricky> <20001121235529.E925@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> On Tue, 21 Nov 2000 22:25:01 Bartlomiej Zolnierkiewicz wrote:
> > -static int dataPort = 0;     /* port for register data */
> > +static int dataPort; /* port for register data */
> 
> That is not too much confidence on the ANSI-ness of the compiler ???

There is nothing wrong with that change.  Standard kernel style cleanup,
which saves a few bytes in the output kernel image.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
