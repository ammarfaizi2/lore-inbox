Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTEWB45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 21:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbTEWB45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 21:56:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44513 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263587AbTEWB44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 21:56:56 -0400
Date: Thu, 22 May 2003 19:07:29 -0700 (PDT)
Message-Id: <20030522.190729.55739270.davem@redhat.com>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Zero the reserved bytes of sadb_prob in af_key.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030522223038.GA31759@gondor.apana.org.au>
References: <20030522223038.GA31759@gondor.apana.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Herbert Xu <herbert@gondor.apana.org.au>
   Date: Fri, 23 May 2003 08:30:38 +1000

   According to RFC2367, all reserved bytes must be set to zero.  This
   patch does just that for the sadb_prop messages.

I applied your fix except that I decided to use memset().

Please use netdev@oss.sgi.com and/or linux-net@vger.kernel.org
in the future.  Most networking hackers don't read linux-kernel
and thus wouldn't be able to review your fix.

Thanks.
