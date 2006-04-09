Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWDIFeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWDIFeJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 01:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWDIFeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 01:34:09 -0400
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:46089
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1751363AbWDIFeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 01:34:07 -0400
Date: Sun, 9 Apr 2006 15:33:38 +1000
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mm-commits@vger.kernel.org
Subject: Re: + git-klibc-mktemp-fix.patch added to -mm tree
Message-ID: <20060409053338.GA13337@gondor.apana.org.au>
References: <200604080707.k38778VV023208@shell0.pdx.osdl.net> <20060408201412.GA26946@mars.ravnborg.org> <44381C9A.3050502@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44381C9A.3050502@zytor.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2006 at 01:27:06PM -0700, H. Peter Anvin wrote:
>
> Herbert: can the code be restructured with appropriate casts so that 
> signed/unsigned is factored out of mksyntax?  As it currently stands, 
> it's not cross-compile-safe, which is unacceptable.

Sure, I'll send you a patch to convert it to always use unsigned char.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
