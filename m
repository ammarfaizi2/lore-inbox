Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVCGVaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVCGVaD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVCGV3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:29:08 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:34744 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261767AbVCGVYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:24:25 -0500
Date: Tue, 8 Mar 2005 00:49:44 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       cryptoapi@lists.logix.cz, David Miller <davem@davemloft.net>
Subject: Re: [0/many] Acrypto - asynchronous crypto layer for linux kernel
 2.6
Message-ID: <20050308004944.60fedb51@zanzibar.2ka.mipt.ru>
In-Reply-To: <1110229998.13172.48.camel@ghanima>
References: <11102278521318@2ka.mipt.ru>
	<1110229998.13172.48.camel@ghanima>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 08 Mar 2005 00:23:42 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2005 22:13:18 +0100
Fruhwirth Clemens <clemens@endorphin.org> wrote:

> On Mon, 2005-03-07 at 23:37 +0300, Evgeniy Polyakov wrote:
> 
> > I'm pleased to announce asynchronous crypto layer for Linux kernel 2.6.
> 
> Thanks Evgeniy for your work! Even though, it's great what's inside, I'm
> afraid it will be judged by the form of its presentation. A patch should
> be something integral, testable on its own. I think it's not necessary
> to package it that fine grained, as it becomes very hard to apply with a
> regular mail reader (Saving/Exporting 50 mails is really a bit of a
> work).
> 
> So, the form is a bit suboptimal. Don't hesitate to put all "acrypto*"
> and "arch*" patches in one-large acrypto patch set, and an other for
> "bd*". I'd be glad to say something different, but I think acrypto has
> not been considered by the maintainers to be merged soon, so patch
> splitting doesn't make sense anyway at the moment.

Unfortunately acrypto patch is more than 200kb, so neither mail list 
will accept it, so I've sent it in such form :)

Actually the most interesting is the first e-mail with subject line
"[0/many] Acrypto - asynchronous crypto layer for linux kernel 2.6" which 
has description of the acrypto layer and it's features.
Acrypto patches itself live in patches with prefix "acrypto" 
[it is from 1 to 21].
bd lives in the last five patches.
Several first e-mails without first number ([??/many]...) are 
various descriptions.

E-mail with subject line 
"[??/many] list of files to be sent in a next couple of e-mails with small description"
contains small one line description of each e-mail.

Sorry for such form, but it is really big set of information pieces, 
so I combined it in a such way.

> Best Regards,
> -- 
> Fruhwirth Clemens - http://clemens.endorphin.org 
> for robots: sp4mtrap@endorphin.org
> 


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
