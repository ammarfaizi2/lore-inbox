Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270013AbRHJUFl>; Fri, 10 Aug 2001 16:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270010AbRHJUFV>; Fri, 10 Aug 2001 16:05:21 -0400
Received: from mail.mediaways.net ([193.189.224.113]:53991 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S270004AbRHJUFL>; Fri, 10 Aug 2001 16:05:11 -0400
Date: Fri, 10 Aug 2001 22:05:02 +0200
From: Walter Hofmann <walterh@gmx.de>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac11
Message-ID: <20010810220502.A32055@frodo.uni-erlangen.de>
In-Reply-To: <20010810163517.A4581@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010810163517.A4581@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Fri, Aug 10, 2001 at 04:35:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this compile error with 2.4.7ac11. Last version I tried was
2.4.6ac1, which worked fine.

Walter


make[4]: Entering directory
`/usr/src/linux-2.4.7-ac11-int2.4.3.1-path/drivers/scsi/aic7xxx/aicasm'
gcc -I/usr/include -I. -ldb aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c -o aicasm /usr/i486-linux/bin/ld: cannot open -ldb: No
such file or directory collect2: ld returned 1 exit status make[4]: ***
[aicasm] Error 1 make[4]: Leaving directory
`/usr/src/linux-2.4.7-ac11-int2.4.3.1-path/drivers/scsi/aic7xxx/aicasm'
make[3]: *** [aicasm/aicasm] Error 2 make[3]: Leaving directory
`/usr/src/linux-2.4.7-ac11-int2.4.3.1-path/drivers/scsi/aic7xxx'
make[2]: *** [_modsubdir_aic7xxx] Error 2 make[2]: Leaving directory
`/usr/src/linux-2.4.7-ac11-int2.4.3.1-path/drivers/scsi' make[1]: ***
[_modsubdir_scsi] Error 2 make[1]: Leaving directory
`/usr/src/linux-2.4.7-ac11-int2.4.3.1-path/drivers' make: ***
[_mod_drivers] Error 2

