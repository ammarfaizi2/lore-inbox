Return-Path: <linux-kernel-owner+w=401wt.eu-S1755222AbXAAPPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222AbXAAPPU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 10:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755224AbXAAPPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 10:15:20 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:3087 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222AbXAAPPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 10:15:19 -0500
Date: Mon, 1 Jan 2007 16:15:06 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Mailing List <netfilter@lists.netfilter.org>
Subject: Re: chaostables-0.2 & 2.6.19.1
Message-ID: <20070101151505.GE7816@vanheusden.com>
References: <20070101143812.GA7816@vanheusden.com>
	<Pine.LNX.4.61.0701011541130.21491@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0701011541130.21491@yvahk01.tjqt.qr>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Tue Jan  2 15:31:19 CET 2007
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >I'm trying to compile chaostables v0.2 on a system with kernel 2.6.19.1
> >and c-compiler 3.4.6:
> >root@muur:/usr/src/chaostables-0.2/kernel# make all
> >make -C /lib/modules/2.6.19.1/build M=$PWD modules;
> >make[1]: Entering directory `/usr/src/linux-2.6.19.1'
> >  CC [M]  /usr/src/chaostables-0.2/kernel/xt_CHAOS.o
> >/usr/src/chaostables-0.2/kernel/xt_CHAOS.c: In function `xt_chaos_target':
> >/usr/src/chaostables-0.2/kernel/xt_CHAOS.c:53: error: too many arguments to function
> Yes I found this one this morning. The issue is simple: function 
> signatures have changed in 2.6.19 and 2.6.20 which I did not all catch 
> yet. chaostables compiles fine with 2.6.18 however. I shall have it 
> workarounded in the next release. Thanks for noticing! (cc to 
> linuxkernel and netfilter before more people run into the same problem)

Not wanting to put you under pressure but when is that version expected?


Folkert van Heusden

-- 
Looking for a cheap but fast webhoster with an excellent helpdesk?
http://keetweej.vanheusden.com/redir.php?id=1001
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
