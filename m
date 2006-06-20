Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWFTK01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWFTK01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWFTK00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:26:26 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:48907 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932585AbWFTK0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:26:25 -0400
Date: Tue, 20 Jun 2006 20:26:11 +1000
To: Joachim Fritschi <jfritschi@freenet.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH  1/4] Twofish cipher - split out common c code
Message-ID: <20060620102611.GA13801@gondor.apana.org.au>
References: <200606041516.21967.jfritschi@freenet.de> <Pine.LNX.4.64.0606181551580.17704@scrub.home> <20060619061813.GA28582@gondor.apana.org.au> <200606191612.37744.jfritschi@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606191612.37744.jfritschi@freenet.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 04:12:37PM +0200, Joachim Fritschi wrote:
> This patch is now based on the cryptodev tree. The last patches where against
> 2.6.17. I somehow missed you announcement about the api change (ctx -> tfm).
> I also did the formating changes and the header fix you asked for.
> 
> Signed-off-by: Joachim Fritschi <jfritschi@freenet.de>

Thanks, I've applied this one.

BTW, I had to add a few missing bits to twofish_common.c.  Next time
please make sure that you provide at least a MODULE_LICENSE and a
module_exit function.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
