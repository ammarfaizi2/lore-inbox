Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbTEFDJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTEFDJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:09:12 -0400
Received: from rth.ninka.net ([216.101.162.244]:47024 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262326AbTEFDJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:09:10 -0400
Subject: Re: Can't compile ipv[46] with ipsec (2.5.69)
From: "David S. Miller" <davem@redhat.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16055.8153.961744.506917@wombat.chubb.wattle.id.au>
References: <16055.8153.961744.506917@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052191294.983.7.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 May 2003 20:21:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 19:37, Peter Chubb wrote:
> I think that the config files are a bit confused.  Surely
> CONFIG_INET_AH should depend on CONFIG_CRYPTO_HMAC ???

Other way around, check crypto/Kconfig.  You have to do
something explicitly to override it.

-- 
David S. Miller <davem@redhat.com>
