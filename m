Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272876AbTG3Msz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272872AbTG3Msz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:48:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:50397 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S272870AbTG3Msx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:48:53 -0400
From: Christian =?iso-8859-15?q?Borntr=E4ger?= 
	<christian@borntraeger.net>
To: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Linux v2.6.0-test2
Date: Wed, 30 Jul 2003 14:48:42 +0200
User-Agent: KMail/1.5.2
References: <E19hp35-0000U6-00@gondolin.me.apana.org.au>
In-Reply-To: <E19hp35-0000U6-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307301448.42899.christian@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 July 2003 13:23, Herbert Xu wrote:
> Christian Borntr?ger <christian@borntraeger.net> wrote:
> > Linus Torvalds wrote:
> >> Herbert Xu:
> >>   o [IPSEC]: Make reqids 32-bits
> >
> > Is this the reason why I can connect
> > 2.6.0-test1 with 2.6.0-test1
> > 2.6.0-test2 with 2.6.0-test2
> >
> > but 2.6.0-test1 cannot connect to 2.6.0-test2 with ipsec?
>
> Does it work after you recompile your user space tools against
> headers from 2.6.0-test2?

I recompiled ipsec-tools and it solved the problem. 

thanks and cheers

Christian

