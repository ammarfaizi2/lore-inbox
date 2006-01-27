Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWA0BWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWA0BWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 20:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWA0BWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 20:22:35 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:44804 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S964819AbWA0BWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 20:22:34 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David H?rdeman <david@2gen.com>
Subject: Re: [PATCH 00/04] Add DSA key type
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, david@2gen.com
Organization: Core
In-Reply-To: <11380489522362@2gen.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1F2IJr-0007Gu-00@gondolin.me.apana.org.au>
Date: Fri, 27 Jan 2006 12:22:31 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David H?rdeman <david@2gen.com> wrote:
>
> 3) Changes the keyctl syscall to accept six arguments (is it valid to do so?)
>   and adds encryption as one of the supported ops for in-kernel keys.

The asymmetric encryption support should be done inside the crypto/
framework rather than as an extension to the key management system.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
