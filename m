Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTFDFJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 01:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTFDFJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 01:09:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30421 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262855AbTFDFJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 01:09:37 -0400
Date: Tue, 03 Jun 2003 22:18:27 -0700 (PDT)
Message-Id: <20030603.221827.38683645.davem@redhat.com>
To: herbert@gondor.apana.org.au
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: esp name conflict with drivers/char/esp.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030603114050.GA32065@gondor.apana.org.au>
References: <20030603114050.GA32065@gondor.apana.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Herbert Xu <herbert@gondor.apana.org.au>
   Date: Tue, 3 Jun 2003 21:40:50 +1000
   
   So one of them's got to be renamed.  Do you have a preference as to
   which way to go?

I've renamed {esp,ah}.c to {esp4,ah4}.c, plus necessary Makefile
changes, in my tree(s).

Thanks.
