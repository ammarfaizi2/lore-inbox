Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbUL2F64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbUL2F64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 00:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbUL2F64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 00:58:56 -0500
Received: from pat.uio.no ([129.240.130.16]:59614 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261324AbUL2F6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 00:58:54 -0500
Subject: Re: [sunrpc] remove xdr_kmap()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "David S. Miller" <davem@davemloft.net>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20041228194925.3443fbd3.davem@davemloft.net>
References: <20041228230416.GM771@holomorphy.com>
	 <20041228171246.496f3eab.davem@davemloft.net>
	 <20041229020938.GN771@holomorphy.com>
	 <20041228194925.3443fbd3.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 29 Dec 2004 06:57:32 +0100
Message-Id: <1104299852.3976.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 28.12.2004 Klokka 19:49 (-0800) skreiv David S. Miller:

> There is a flush_dcache_page() call for xdr_partial_copy_from_skb()
> but calls are also needed in _copy_to_pages() and
> _shift_data_right_pages().

Will do.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

