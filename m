Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVCHU3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVCHU3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVCHU1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:27:48 -0500
Received: from hera.kernel.org ([209.128.68.125]:5069 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262171AbVCHTuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:50:46 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [2.6 patch] better CRYPTO_AES <-> CRYPTO_AES_586 dependencies
Date: Tue, 8 Mar 2005 19:50:25 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <d0kvm1$j1b$1@terminus.zytor.com>
References: <20050225214613.GF3311@stusta.de> <421FA1C7.2080201@nortel.com> <20050225222938.GG3311@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1110311425 19500 127.0.0.1 (8 Mar 2005 19:50:25 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 8 Mar 2005 19:50:25 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050225222938.GG3311@stusta.de>
By author:    Adrian Bunk <bunk@stusta.de>
In newsgroup: linux.dev.kernel
> > 
> > Wouldn't the 586 one also work on x86_64?
> 
> I'd assume yes.
> 
> But the CRYPTO_AES_586 were already this way, and since I don't know the 
> history of these dependencies this isn't changed by my patch.
> 

Anything written in assembly would have to be specifically adjusted to
work on x86-64 (different ABI, 64-bit pointers, etc.)

	-hpa
