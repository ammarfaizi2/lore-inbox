Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVCBWWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVCBWWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVCBWTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:19:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:42685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262509AbVCBWRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:17:36 -0500
Date: Wed, 2 Mar 2005 14:14:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.11-rc4-mm1 patch] fix buggy IEEE80211_CRYPT_* selects
Message-Id: <20050302141415.517b6b08.akpm@osdl.org>
In-Reply-To: <20050302215607.GF4608@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org>
	<20050226113123.GJ3311@stusta.de>
	<42256078.1040002@pobox.com>
	<20050302140833.GD4608@stusta.de>
	<42261004.4000501@pobox.com>
	<20050302123829.51dbc44b.akpm@osdl.org>
	<42262B08.2040401@pobox.com>
	<20050302131817.2e61805f.akpm@osdl.org>
	<20050302215607.GF4608@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> > Would be better to just do:
> > 
> > config CRYPTO_AES
> > 	select CRYPTO_AES_586 if (X86 && !X86_64)
> > 	select CRYPTO_AES_OTHER if !(X86 && !X86_64)
> > 
> > and hide CRYPTO_AES_586 and CRYPTO_AES_OTHER from the outside world.
> 
> 
>   http://www.ussg.iu.edu/hypermail/linux/kernel/0502.3/0518.html

Please resubmit.
