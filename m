Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264379AbUD0Wfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbUD0Wfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbUD0Wfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:35:45 -0400
Received: from ns.suse.de ([195.135.220.2]:1162 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264379AbUD0Wfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:35:43 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 4/11] sunrpc-xdr-words
Date: Wed, 28 Apr 2004 00:37:15 +0200
User-Agent: KMail/1.6.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <1082975183.3295.74.camel@winden.suse.de> <20040427211926.GA4319@fieldses.org>
In-Reply-To: <20040427211926.GA4319@fieldses.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404280037.15274.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bruce,

thanks, we can move both functions into include/linux/sunrpc/xdr.h; they are 
trivial enough.

On Tuesday 27 April 2004 23:19, J. Bruce Fields wrote:
> On Mon, Apr 26, 2004 at 12:28:48PM +0200, Andreas Gruenbacher wrote:
> > Encode 32-bit words in xdr_buf's
> > +extern int read_u32_from_xdr_buf(struct xdr_buf *, int, u32 *);
>
> Note that the same function is defined as a static inline in
> net/sunrpc/auth_gss/svcauth_gss.c, so gcc will complain if
> CONFIG_SUNRPC_GSS is also defined.
>
> --Bruce Fields

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG
