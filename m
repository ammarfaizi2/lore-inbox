Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUAGPVh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 10:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266192AbUAGPVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 10:21:36 -0500
Received: from arhont1.eclipse.co.uk ([81.168.98.121]:20099 "EHLO
	pingo.core.arhont.com") by vger.kernel.org with ESMTP
	id S266166AbUAGPVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 10:21:33 -0500
Message-ID: <3FFC240C.20408@arhont.com>
Date: Wed, 07 Jan 2004 15:21:48 +0000
From: Andrei Mikhailovsky <andrei@arhont.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Lorenzo Hernandez Garcia-Hierro <lorenzohgh@nsrg-security.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems in 2.4.18 with madwifi
References: <1073486703.850.24.camel@zeus>
In-Reply-To: <1073486703.850.24.camel@zeus>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.6 (-)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you should post it to madwifi mail list at:

madwifi-users@lists.sourceforge.net

P.S. I've compiled madiwif on debian and slackware on kernels 2.4.20-23 
and 2.6.0-2.6.1-rc1 without any problems. Try the latest cvs of madwifi

Regards

Lorenzo Hernandez Garcia-Hierro wrote:
> Hi,
> 
> I am having trouble on a madwifi installation :
> 
> When compiling wlan.o it tries to get the net/iw_handler.h but i am
> running Debian with 2.4.18 ( i can boot with 2.4.18 , 2.4.22 and 2.6.0
> ).
> 
> Where is the problem ?
>  Here are the little snippets of errors :
> 
> gcc -M -include ../include/compat.h -I../include -I.
> -I/lib/modules/2.4.18/build/include
> -I/lib/modules/2.4.18/build/arch/i386 -I..  -Wall -Wno-trigraphs -O2
> -D__KERNEL__ -DMODULE -D__linux__ -fomit-frame-pointer
> -DAH_BYTE_ORDER=AH_LITTLE_ENDIAN -fomit-frame-pointer if_ieee80211subr.c
> if_ieee80211wireless.c if_media.c rc4.c > .depend
> if_ieee80211wireless.c:54: net/iw_handler.h: No such file or directory
> make[1]: *** [.depend] Error 1
> make[1]: Leaving directory `/usr/src/madwifi/wlan'
> make[1]: Entering directory `/usr/src/madwifi/driver'
> rm -f .depend
> 
> Thanks in advance.
> NOTE: I am installing it with 2.4.18 and a Orinoco b/g card from proxim
> ( atheros chip ).
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
Andrei Mikhailovsky
Financial Director
Arhont Ltd

Web: http://www.arhont.com
Tel: +44 (0)870 4431337
Fax: +44 (0)1454 201200
PGP: Key ID - 0xFF67A4F4
PGP: Server - gpg.arhont.com

