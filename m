Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266909AbUFZBCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266909AbUFZBCG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 21:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUFZBCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 21:02:06 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:24334 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266909AbUFZBCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 21:02:03 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: nkukard@lbsd.net (Nigel Kukard)
Subject: Re: [HANG] SIS900 + P4 Hyperthread
Cc: romieu@fr.zoreil.com, webvenza@libero.it, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20040625145403.GI11501@lbsd.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1Be1ZB-0004BJ-00@gondolin.me.apana.org.au>
Date: Sat, 26 Jun 2004 11:01:13 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Kukard <nkukard@lbsd.net> wrote:
> 
> It must be non-sis900 driver related, is there a way i can get more
> debugging info?

Please try booting with noapic and/or acpi=off.  APIC is known to
cause problems on many SIS chipsets.
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
