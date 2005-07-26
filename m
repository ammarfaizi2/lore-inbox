Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVGZRx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVGZRx2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVGZRvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:51:20 -0400
Received: from pat.uio.no ([129.240.130.16]:58859 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261898AbVGZRtB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:49:01 -0400
Subject: Re: [PATCH NFS 3/3] Replace nfs_block_bits() with
	roundup_pow_of_two()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050725155611.GA12856@lsrfire.ath.cx>
References: <20050724143640.GA19941@lsrfire.ath.cx>
	 <1122246549.8322.3.camel@lade.trondhjem.org>
	 <1122247463.8322.19.camel@lade.trondhjem.org>
	 <20050725155611.GA12856@lsrfire.ath.cx>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Jul 2005 13:48:46 -0400
Message-Id: <1122400127.6894.32.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.424, required 12,
	autolearn=disabled, AWL 2.39, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 25.07.2005 Klokka 17:56 (+0200) skreiv Rene Scharfe:

> What's your opinion of the following patch, which explicitly states the
> intent of nfs_block_bits()?  It still needs patch 1 and 2.

I really don't like the choice of name. If you feel you must change the
name, then make it something like nfs_blocksize_align(). That describes
its function, instead of the implementation details.

Cheers,
  Trond

