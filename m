Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVBYWBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVBYWBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVBYWBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:01:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5045 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262114AbVBYWBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:01:31 -0500
Date: Fri, 25 Feb 2005 17:00:25 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Adrian Bunk <bunk@stusta.de>
cc: davem@davemloft.net, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] better CRYPTO_AES <-> CRYPTO_AES_586 dependencies
In-Reply-To: <20050225214613.GF3311@stusta.de>
Message-ID: <Xine.LNX.4.44.0502251659060.11414-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2005, Adrian Bunk wrote:

> 2.6.11-rc4-mm1 contains an option (IEEE80211_CRYPT_CCMP) that selects 
> CRYPTO_AES - but this is currently wrong on i386.
> 
> This patch changes CRYPTO_AES to being the only user-visible options and 
> selecting either CRYPTO_AES_586 or a new CRYPTO_AES_GENERIC option 
> depending on the platform.

Good thinking, didn't think to chain selects.

> BTW: Does CRYPTO_AES_586 work on an 386 or 486?

>From memory it is generic i386 asm optimize for P5.


- James
-- 
James Morris
<jmorris@redhat.com>


