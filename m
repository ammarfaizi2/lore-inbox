Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265867AbUEUN0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265867AbUEUN0f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 09:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265868AbUEUN0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 09:26:35 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:27916 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265867AbUEUN0e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 09:26:34 -0400
Date: Fri, 21 May 2004 23:26:18 +1000
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
Message-ID: <20040521132617.GA24385@gondor.apana.org.au>
References: <20040521100734.GA31550@elf.ucw.cz> <E1BR7pl-0000Br-00@gondolin.me.apana.org.au> <20040521111612.GA976@elf.ucw.cz> <20040521111828.GA870@gondor.apana.org.au> <20040521112209.GA951@gondor.apana.org.au> <20040521114125.GA10052@elf.ucw.cz> <40ADFED4.4000601@linuxmail.org> <20040521131916.GF10052@elf.ucw.cz> <40AE01C0.6030500@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AE01C0.6030500@linuxmail.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 11:18:56PM +1000, Nigel Cunningham wrote:
> 
> Pavel Machek wrote:
> >Aha, okay then. How should the option be called, then?
> 
> Since we're all using it, is there a problem with just using CONFIG_PM?

Well it is possible to use CONFIG_PM without doing suspend-to-disk,
but I guess no one will notice if we just slipped it in :)
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
