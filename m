Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbUL2CJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbUL2CJn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 21:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbUL2CJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 21:09:43 -0500
Received: from holomorphy.com ([207.189.100.168]:46305 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261301AbUL2CJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 21:09:40 -0500
Date: Tue, 28 Dec 2004 18:09:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [sunrpc] remove xdr_kmap()
Message-ID: <20041229020938.GN771@holomorphy.com>
References: <20041228230416.GM771@holomorphy.com> <20041228171246.496f3eab.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041228171246.496f3eab.davem@davemloft.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 15:04:16 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:
>> In this process, I stumbled over a blatant kmap() deadlock in
>> xdr_kmap(), which fortunately is never called.

On Tue, Dec 28, 2004 at 05:12:46PM -0800, David S. Miller wrote:
> This got zapped by a cleanup patch by Adrian Bunk which
> I applied yesterdat.  Linus just hasn't pulled from my
> tree yet.

Sounds good. I only missed it because it was in the middle of a
larger set of changes. Now I just have to find where in nfs the
missing flush_dcache_page() calls need to be so I can boot 2.6
on a bunch of boxen.


-- wli
