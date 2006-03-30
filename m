Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWC3PJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWC3PJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 10:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWC3PJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 10:09:41 -0500
Received: from pat.uio.no ([129.240.10.6]:65484 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750784AbWC3PJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 10:09:40 -0500
Subject: Re: NFS/Kernel Problem: getfh failed: Operation not permitted
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0603300949000.18696@p34>
References: <Pine.LNX.4.64.0603300813270.18696@p34>
	 <1143728720.8074.41.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0603300929340.18696@p34>
	 <1143729766.8074.49.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0603300949000.18696@p34>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 10:09:24 -0500
Message-Id: <1143731364.8074.53.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.707, required 12,
	autolearn=disabled, AWL 1.11, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 09:50 -0500, Justin Piszcz wrote:
> I tried an exportfs -rv and it did not help.  Any other suggestions?

Did the output from 'exportfs -rv' match with the contents
of /etc/exports? If so, did it also match with the contents
of /var/lib/nfs/xtab and /proc/fs/nfs/exports?

Cheers,
  Trond

