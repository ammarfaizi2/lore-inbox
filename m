Return-Path: <linux-kernel-owner+w=401wt.eu-S932232AbXAHIte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbXAHIte (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbXAHIte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:49:34 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:60223 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbXAHIte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:49:34 -0500
X-Originating-Ip: 74.109.98.176
Date: Mon, 8 Jan 2007 03:44:01 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Sumit Narayan <talk2sumit@gmail.com>
cc: Amit Choudhary <amit2030@yahoo.com>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Hua Zhong <hzhong@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
In-Reply-To: <1458d9610701080039m50d63d82w59cd917691edcb03@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701080342090.26841@localhost.localdomain>
References: <84144f020701080000v460a9f3aja9570e72fa457934@mail.gmail.com> 
 <810563.91187.qm@web55604.mail.re4.yahoo.com>
 <1458d9610701080039m50d63d82w59cd917691edcb03@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007, Sumit Narayan wrote:

> Asking for KFREE is as silly as asking for a macro to check if
> kmalloc succeeded for a pointer, else return ENOMEM.
>
> #define CKMALLOC(p,x) \
>   do {   \
>       p = kmalloc(x, GFP_KERNEL); \
>       if(!p) return -ENOMEM; \
>    } while(0)

oooooooh ... cool.  i'll whip up a patch for that right away.

rday

p.s.  i'm *kidding*, for god's sake.  um ... what are you doing?  and
where did you get that tire iron?  no, wait ...
