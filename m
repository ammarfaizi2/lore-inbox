Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbVAQUnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVAQUnp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVAQUnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:43:45 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:13316 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262882AbVAQUle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:41:34 -0500
Date: Tue, 18 Jan 2005 07:39:30 +1100
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Cc: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [rfc] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050117203930.GA9605@gondor.apana.org.au>
References: <20050117183708.GD4348@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117183708.GD4348@tuxdriver.com>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 01:37:08PM -0500, John W. Linville wrote:
> "Some" OSS applications have trouble with later versions of the
> i810_audio driver.  Wolfenstein Enemy Territory from idSoftware is
> one such application.

Would it be possible to create a minimal program (something that triggers
a start through __i810_update_lvi) that reproduces this problem?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
