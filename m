Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268236AbUJMC0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUJMC0D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 22:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUJMC0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 22:26:03 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:52996 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S268236AbUJMC0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 22:26:01 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: akropel1@rochester.rr.com (Adam Kropelin)
Subject: Re: [linux-usb-devel] Re: [HID] Fix hiddev devfs oops
Cc: herbert@gondor.apana.org.au, zaitcev@redhat.com,
       marcelo.tosatti@cyclades.com, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <004a01c4b0be$c33a28e0$03c8a8c0@kroptech.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.usb.devel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CHYko-0006rt-00@gondolin.me.apana.org.au>
Date: Wed, 13 Oct 2004 12:20:38 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin <akropel1@rochester.rr.com> wrote:
> 
> Another scenario to keep in mind is unplugging a USB device while a process 
> still has its corresponding hiddev node open. I fixed that issue in 2.6 a 
> while ago. I'm not sure if 2.4 is susceptible. It may or may not be 
> orthogonal to the problem your patch addresses.

It is unrelated to my issue but yet that fix is needed in 2.4 as well.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
