Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbTGWKjO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 06:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267587AbTGWKjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 06:39:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10129 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S267576AbTGWKiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 06:38:25 -0400
Date: Wed, 23 Jul 2003 03:50:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: a.marsman@aYniK.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre7: are security issues solved?
Message-Id: <20030723035022.23a75bc5.davem@redhat.com>
In-Reply-To: <20030723104753.GA2479@gondor.apana.org.au>
References: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain>
	<E19fGMZ-0000Zm-00@gondolin.me.apana.org.au>
	<20030723033505.145db6b8.davem@redhat.com>
	<20030723104753.GA2479@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 20:47:53 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Wed, Jul 23, 2003 at 03:35:05AM -0700, David S. Miller wrote:
> > If I know your password is 7 characters I have a smaller
> > space of passwords to search to just brute-force it.
> 
> It's much smaller if you didn't know that it was at most 7 characters
> long.  However, if you did know the upper bound, or you were just
> brute forcing all passwords starting from 1 character, then the
> difference is relatively minor.  This is because
> 
> n + n^2 + n^3 + n^4 + n^5 + n^6
> 
> is much smaller than n^7 where n is something like 62 for a reasonable
> password.

"7" in my example is an arbitrary number, increase it to any larger
number you like.
