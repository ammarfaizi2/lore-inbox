Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbTGBJr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 05:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbTGBJrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 05:47:25 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:55813 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S264887AbTGBJrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 05:47:21 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jbriggs@briggsmedia.com (joe briggs), linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 IDE problems (lost interrupt, bad DMA status)
In-Reply-To: <200307020634.42705.jbriggs@briggsmedia.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.21-1-686-smp (i686))
Message-Id: <E19XeQ3-0008RI-00@gondolin.me.apana.org.au>
Date: Wed, 02 Jul 2003 20:00:55 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joe briggs <jbriggs@briggsmedia.com> wrote:
> Can anyone tell me what the -ac patches do with respect to this problem?  
> Also, what functionality is lost when CONFIG_X86_IO_APIC is not set, and 
> should it improve this hd timeout/lost interrupt problem?

It fixes the problem where interrupts are lost when the relevant IRQ line
is disabled.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
