Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267501AbUBSTV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267488AbUBSTUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:20:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:15493 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267494AbUBSTSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:18:40 -0500
Date: Thu, 19 Feb 2004 11:18:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-Id: <20040219111835.192d2741.akpm@osdl.org>
In-Reply-To: <20040219170228.GA10483@leto.cs.pocnet.net>
References: <20040219170228.GA10483@leto.cs.pocnet.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> wrote:
>
> Hello,
> 
> since some people keep complaining that the IV generation mechanisms
> supplied in cryptoloop (and now dm-crypt) are insecure, which they
> somewhat are, I just hacked a small digest based IV generation mechanism.
> 
> It simply hashes the sector number and the key and uses it as IV.
> 
> You can specify the encryption mode as "cipher-digest" like aes-md5 or
> serpent-sha1 or some other combination.

hmm.

> Consider this as a proposal, I'm not a crypto expert.

Me either.  But I believe that there are crypto-savvy people reading this
list.  Help would be appreciated.

