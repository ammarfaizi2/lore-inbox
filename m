Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbSKKOHe>; Mon, 11 Nov 2002 09:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265293AbSKKOHe>; Mon, 11 Nov 2002 09:07:34 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:51976 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S265255AbSKKOHe>; Mon, 11 Nov 2002 09:07:34 -0500
Date: Tue, 12 Nov 2002 01:14:15 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Allan Duncan <allan.d@bigpond.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.47 (CONFIG_CRYPTO)
In-Reply-To: <3DCF9D32.8070006@bigpond.com>
Message-ID: <Mutt.LNX.4.44.0211120106580.17844-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2002, Allan Duncan wrote:

> New - undefined refs if CONFIG_CRYPTO is not set.

This is due to the ah and esp modules (and af_key soon).  We need to
either make these modules depend on CONFIG_CRYPTO or force CONFIG_CRYPTO
(plus the ipsec algorithms) when any of these modules selected.


- James
-- 
James Morris
<jmorris@intercode.com.au>



