Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVBORbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVBORbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVBOR3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:29:18 -0500
Received: from pat.uio.no ([129.240.130.16]:42396 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261793AbVBORYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:24:32 -0500
Subject: Re: [patch 8/13] Add noacl nfs mount option
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050122203619.669767000@blunzn.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203619.669767000@blunzn.suse.de>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 12:24:17 -0500
Message-Id: <1108488257.10073.36.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.948, required 12,
	autolearn=disabled, AWL 2.05, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lau den 22.01.2005 Klokka 21:34 (+0100) skreiv Andreas Gruenbacher:
> vanlig tekstdokument vedlegg (patches.suse)
> With the noacl mount option, nfs clients stop using the ACCESS RPC
> which they usually use to get an access decision from the server.
> Instead, they make the decision based on the file ownership and
> file mode permission bits.

I still hate that name "noacl".

It isn't just that "no acls are being used on the server". It is "no
acls and no *uid/gid mapping* is being used on the server".

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

