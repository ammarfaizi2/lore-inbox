Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVCZU7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVCZU7P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 15:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVCZU7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 15:59:15 -0500
Received: from hera.kernel.org ([209.128.68.125]:4247 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261259AbVCZU7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 15:59:11 -0500
Date: Sat, 26 Mar 2005 13:07:01 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc2
Message-ID: <20050326160701.GD19501@logos.cnet>
References: <20050326004631.GC17637@logos.cnet> <20050326112256.GN30052@alpha.home.local> <1111837493.8042.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111837493.8042.2.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 12:44:53PM +0100, Arjan van de Ven wrote:
> On Sat, 2005-03-26 at 12:22 +0100, Willy Tarreau wrote:
> > Marcelo,
> > 
> > here's a patch from Dave Jones, which is already in 2.6 and which I've
> > used in my local tree for 6 months now. It removes a useless NULL check
> > in zlib_inflateInit2_(), since 'z' is already dereferenced one line
> > before the test. Can in go in 2.4.30 please ?
> 
> I don't see how such a cleanup-only patch would be a candidate for 2.4
> at all, let alone to go into a -rc3 or a 2.4.30 final at this stage...
> 
> Can you explain why this one is so important that it has to go in so
> late?

I second. 

Willy, please resend the other ones for 2.4.31-pre ok?

Should have held the JFS one also.

