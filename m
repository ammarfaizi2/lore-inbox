Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVLPT5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVLPT5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVLPT5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:57:44 -0500
Received: from pat.uio.no ([129.240.130.16]:2791 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932388AbVLPT5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:57:44 -0500
Subject: Re: [PATCH 3/3] Fix problems on multi-TB filesystem and file
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Takashi Sato <sho@tnes.nec.co.jp>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <2cd57c900512161139n7d738415q@mail.gmail.com>
References: <000201c60242$318eff70$4168010a@bsd.tnes.nec.co.jp>
	 <2cd57c900512161139n7d738415q@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 14:57:28 -0500
Message-Id: <1134763048.18635.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.79, required 12,
	autolearn=disabled, AWL 1.02, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 03:39 +0800, Coywolf Qi Hunt wrote:

> That CONFIG_LBD is disabled means the kernel is not capable to attach
> a large block device, whether through network or locally attached.  So
> in order to use a large network filesystem, simply enable LBD instead.
>  Don't bother to bring unnecessary overheads.

It may surprise you to learn that not all network filesystems are block
based.

NFS has no truck with CONFIG_LBD at all.

Cheers,
  Trond

