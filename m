Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVBOTRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVBOTRa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVBOTRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:17:30 -0500
Received: from pat.uio.no ([129.240.130.16]:62105 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261828AbVBOTR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:17:27 -0500
Subject: Re: [patch 7/13] Encode and decode arbitrary XDR arrays
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050122203619.570180000@blunzn.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203619.570180000@blunzn.suse.de>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 14:17:18 -0500
Message-Id: <1108495038.10073.102.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.989, required 12,
	autolearn=disabled, AWL 2.01, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lau den 22.01.2005 Klokka 21:34 (+0100) skreiv Andreas Gruenbacher:
> vanlig tekstdokument vedlegg (patches.suse)
> Add xdr_encode_array2 and xdr_decode_array2 functions for encoding
> end decoding arrays with arbitrary entries, such as acl entries. The
> goal here is to do this without allocating a contiguous temporary
> buffer.

net/sunrpc/xdr.c:1024:3: warning: mixing declarations and code
net/sunrpc/xdr.c:967:16: warning: bad constant expression

Please don't use these gcc extensions in the kernel.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

