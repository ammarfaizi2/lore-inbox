Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSJUVLu>; Mon, 21 Oct 2002 17:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbSJUVLu>; Mon, 21 Oct 2002 17:11:50 -0400
Received: from dyn-212-232-23-123.ppp.tiscali.fr ([212.232.23.123]:59919 "EHLO
	calvin.paulbristow.lan") by vger.kernel.org with ESMTP
	id <S261693AbSJUVLs>; Mon, 21 Oct 2002 17:11:48 -0400
Message-ID: <3DB46F23.3010108@paulbristow.net>
Date: Mon, 21 Oct 2002 23:18:27 +0200
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregoire Favre <greg@ulima.unil.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 don't allow ZIP ejection :-((
References: <20021021205829.GA6665@ulima.unil.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the bug report.  We know the BIO code needs going over in 
ide-floppy...  I'll try to take care of it.

Gregoire Favre wrote:

>Hello,
>
>in 2.5.n n<44 the eject command didn't work anymore, but I could
>manually eject my disc...
>
>With 2.5.44 the eject command still don't work, but even worse: I should
>reboot to eject the device:
>
>Oct 21 16:55:57 ulima kernel:  /dev/ide/host0/bus1/target1/lun0: unknown partition tableOct 21 16:55:57 ulima kernel: ide-floppy: unsupported command in queue: dev 16:40: REQ_NOMERGE REQ_STARTED REQ_BLOCK_PC sector 65680, nr/cnr 8/8
>Oct 21 16:55:57 ulima kernel: bio 00000000, biotail 00000000
>Oct 21 16:55:57 ulima kernel: end_request: I/O error, dev 16:40, sector 65680
>
>Thank you,
>
>	Grégoire
>________________________________________________________________
>http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

-- 

Paul

Email:	paul@paulbristow.net
Web:	http://paulbristow.net
ICQ:	11965223


