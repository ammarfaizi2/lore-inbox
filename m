Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268581AbUJTQ45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268581AbUJTQ45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268487AbUJTQwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:52:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:10131 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268670AbUJTQtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:49:11 -0400
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       linux-kernel@gondor.apana.org.au, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net,
       Linux Network Development <netdev@oss.sgi.com>,
       Alain Schroeder <alain@parkautomat.net>
In-Reply-To: <200410201811.44419.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1098230132.23628.28.camel@krustophenia.net>
	 <20041020000009.GA17246@gondor.apana.org.au>
	 <1098231737.23628.42.camel@krustophenia.net>
	 <200410201811.44419.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1098290858.1429.70.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 12:47:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 11:11, Denis Vlasenko wrote:
> 0x57 == 87 bytes is too big for inline.

Ugh.  So the only fix is not to inline it?

Lee

