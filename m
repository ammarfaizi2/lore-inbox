Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbTLaByR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 20:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbTLaByR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 20:54:17 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:3336 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266091AbTLaByO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 20:54:14 -0500
Date: Wed, 31 Dec 2003 01:54:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@osdl.org, Paul Jackson <pj@sgi.com>, anton@samba.org,
       linux-kernel@vger.kernel.org, ioe-lkml@rameria.de,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH 1/2] Make for_each_cpu() Iterator More Friendly
Message-ID: <20031231015410.A12194@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>, akpm@osdl.org,
	Paul Jackson <pj@sgi.com>, anton@samba.org,
	linux-kernel@vger.kernel.org, ioe-lkml@rameria.de,
	William Lee Irwin III <wli@holomorphy.com>
References: <20031231013046.23B3B2C079@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031231013046.23B3B2C079@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Dec 31, 2003 at 12:26:34PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 12:26:34PM +1100, Rusty Russell wrote:
> Please apply.  Applies against 2.6.0-mm2 and 2.6.0-bk3.  Yay!
> 
> Anton: breaks PPC64, as it needs cpu_possible_mask, but fix is already
> in Ameslab tree.

So what about including the fix in the patch?  I don't think a fix in some
obscure tree is a good excuse to break an architecture in a stable series..

