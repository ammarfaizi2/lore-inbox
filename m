Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVBCVPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVBCVPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVBCVPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:15:23 -0500
Received: from hera.kernel.org ([209.128.68.125]:54477 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263125AbVBCVPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:15:16 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] Configure MTU via kernel DHCP
Date: Thu, 3 Feb 2005 21:14:52 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <ctu48c$ovm$1@terminus.zytor.com>
References: <200502022148.00045.shane@hathawaymix.org> <E1CwfQK-00011a-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1107465292 25591 127.0.0.1 (3 Feb 2005 21:14:52 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 3 Feb 2005 21:14:52 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E1CwfQK-00011a-00@gondolin.me.apana.org.au>
By author:    Herbert Xu <herbert@gondor.apana.org.au>
In newsgroup: linux.dev.kernel
> 
> Have you looked at using initramfs and running the DHCP client in
> user space? You'll get a lot more freedom that way.
> 

Note that the klibc distribution already contains a working dhcp
client.  The only thing missing is just "putting the backwards into
backwards compatible", i.e. handling *all* the (sometimes weird)
kernel behaviours for full compatibility.

	-hpa
