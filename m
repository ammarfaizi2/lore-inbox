Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTERFGh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 01:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTERFG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 01:06:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62137 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261968AbTERFGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 01:06:25 -0400
Date: Sat, 17 May 2003 22:17:06 -0700 (PDT)
Message-Id: <20030517.221706.23036524.davem@redhat.com>
To: herbert@gondor.apana.org.au
Cc: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Added missing dependencies on CRYPTO_HMAC
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030518040411.GA7062@gondor.apana.org.au>
References: <20030518031546.GA4943@gondor.apana.org.au>
	<Mutt.LNX.4.44.0305181334280.21675-100000@excalibur.intercode.com.au>
	<20030518040411.GA7062@gondor.apana.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Herbert Xu <herbert@gondor.apana.org.au>
   Date: Sun, 18 May 2003 14:04:11 +1000

   Good point.  What about this patch then?

No, this is gross.  The ipsec protocols should be available by
default, I don't like this message solution at all.

Why don't we do this for every thing that needs ZLIB for example?

The answer is that we don't because it's rediculious.  We instead
define sensible defaults and if the user grinds out his own changes
that override them, as James said, he does so at his own peril.
