Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUEUL0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUEUL0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 07:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265829AbUEUL0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 07:26:19 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:15625 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265823AbUEULZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 07:25:42 -0400
Date: Fri, 21 May 2004 21:25:18 +1000
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org
Subject: Re: swsusp vs. pmdisk [was Re: swsusp: fix swsusp with intel-agp]
Message-ID: <20040521112518.GA1014@gondor.apana.org.au>
References: <20040521100734.GA31550@elf.ucw.cz> <E1BR7pl-0000Br-00@gondolin.me.apana.org.au> <20040521111612.GA976@elf.ucw.cz> <20040521112306.GC976@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521112306.GC976@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 01:23:06PM +0200, Pavel Machek wrote:
> 
> What about killing pmdisk code, instead?
> 
> Its old, its not maintained any more, and it is unneccessary duplicity
> of swsusp code.
> 
> Patrick, in middle of april you claimed you'll have something "by the
> end of month". Can you either start looking after your code or give up
> and let me remove it?

Well if Patrick doesn't have the time to do it, I'd like to maintain
pmdisk.  It might be a bit out-of-date, by with a bit of work, it
can easily catch up again since the underlying structure is quite nice.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
