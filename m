Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbUJaMHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUJaMHg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUJaMBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 07:01:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40577 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261561AbUJaL7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 06:59:17 -0500
Message-ID: <4184D383.1090204@pobox.com>
Date: Sun, 31 Oct 2004 06:58:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Andrew Morton <akpm@osdl.org>, geert@linux-m68k.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH 475] HP300 LANCE
References: <E1COEEO-0002lX-00@gondolin.me.apana.org.au>
In-Reply-To: <E1COEEO-0002lX-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
>>Jeff Garzik <jgarzik@pobox.com> wrote:
>>
>>>On Sun, Oct 31, 2004 at 02:48:40AM -0800, Andrew Morton wrote:
>>> > > -        void *va = dio_scodetoviraddr(scode);
>>> > > +        unsigned long pa = dio_scodetophysaddr(scode);
>>> > > +        unsigned long va = (pa + DIO_VIRADDRBASE);
>>>
>>> Did you see the above quoted patch chunk?  The patch is inconsistent
>>> with _itself_, adding 'pa' and 'va' with different idents (but when they
>>> should be at the same identation level).
>>
>>Trust me ;)
> 
> 
> What Jeff means is that the patch is using a tab for pa and 8 spaces
> for va.


Precisely.  That's what my entire "whitespace challenged" comment meant.

When the patch adds two lines at the same visual indentation level in 
the source, but appear different in the patch, that is a signal that 
some tabs got accidentally converted to spaces somewhere.

	Jeff


