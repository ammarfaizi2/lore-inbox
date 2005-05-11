Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVEKVkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVEKVkr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVEKVkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:40:46 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:27913 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261260AbVEKVkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:40:08 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: marcelo.tosatti@cyclades.com (Marcelo Tosatti)
Subject: Re: 2.4.30-hf1 do_IRQ stack overflows
Cc: manfred99@gmx.ch, linux-kernel@vger.kernel.org, davem@redhat.com,
       netdev@oss.sgi.com
Organization: Core
In-Reply-To: <20050511124640.GE8541@logos.cnet>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DVyuq-0005Sf-00@gondolin.me.apana.org.au>
Date: Thu, 12 May 2005 07:38:52 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> May 11 04:22:09 server kernel:   [__switch_to+82/256] [schedule+738/1344] [schedule_timeout+84/160] [process_timeout+0/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294702743/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294703097/96]

The stack trace becomes unreadable at this point.  Please run klogd
with -X and then decode the messages with ksymoops.  Alternatively
run ksymoops on the output of dmesg directly.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
