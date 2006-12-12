Return-Path: <linux-kernel-owner+w=401wt.eu-S1750699AbWLLA0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWLLA0u (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 19:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWLLA0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 19:26:50 -0500
Received: from pat.uio.no ([129.240.10.15]:59813 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbWLLA0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 19:26:50 -0500
Subject: Re: [2.6.19] NFS: server error: fileid changed
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061211234435.37302.qmail@web32602.mail.mud.yahoo.com>
References: <20061211234435.37302.qmail@web32602.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 19:25:54 -0500
Message-Id: <1165883155.22849.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.779, required 12,
	autolearn=disabled, AWL 1.22, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 15:44 -0800, Martin Knoblauch wrote:
>  So far, we are only seeing it on amd-mounted filesystems, not on
> static NFS mounts. Unfortunatelly, it is difficult to avoid "amd" in
> our environment.

Any chance you could try substituting a recent version of autofs? This
sort of problem is more likely to happen on partitions that are
unmounted and then remounted often. I'd just like to figure out if this
is something that we need to fix in the kernel, or if it is purely an
amd problem.

Cheers
  Trond

