Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVJaMfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVJaMfG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 07:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVJaMfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 07:35:05 -0500
Received: from pat.uio.no ([129.240.130.16]:47769 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932428AbVJaMfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 07:35:04 -0500
Subject: Re: fs/nfs - cleanup function declarations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051031122950.GA12009@home.fluff.org>
References: <20051031122950.GA12009@home.fluff.org>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 07:34:52 -0500
Message-Id: <1130762092.8802.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.743, required 12,
	autolearn=disabled, AWL 1.07, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 12:29 +0000, Ben Dooks wrote:
> Cleanup sparse warnings from fs/nfs, mainly
> due to undeclared functions or missing static
> from functions.
> 
> This patch does the following:
> 
> 1) place static on both the nfs_llseek_dir and
>    nfs_fsync_dir in dir.c as they where earlier
>    declared static
> 
> 2) add shared.h, and put declarations of the
>    init functions into it.
> 
> 3) use inline to remove DIRECTIO initialisation
>    support to cleanup the init/exit code paths
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

ACKed

Cheers,
  Trond

