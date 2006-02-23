Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWBWWrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWBWWrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWBWWrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:47:13 -0500
Received: from pat.uio.no ([129.240.130.16]:4025 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751789AbWBWWrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:47:12 -0500
Subject: Re: NFS Still broken in 2.6.x?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bryan Fink <bfink@eventmonitor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43FE1CAD.3050806@eventmonitor.com>
References: <43FE1CAD.3050806@eventmonitor.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 17:47:03 -0500
Message-Id: <1140734824.7963.38.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.879, required 12,
	autolearn=disabled, AWL 1.12, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 15:35 -0500, Bryan Fink wrote:
> Hi All.  I'm running into a bit of trouble with NFS on 2.6.  I see that
> at least Trond thought, mid-January, that "The readahead algorithm has
> been broken in 2.6.x for at least the past 6 months." (
> http://www.ussg.iu.edu/hypermail/linux/kernel/0601.2/0559.html) Anyone
> know if that has been fixed?

No it hasn't been fixed. ...and no, this is not a problem that only
affects NFS: it just happens to give a more noticeable performance
impact due to the larger latency of NFS over a 100Mbps link.

I will get round to this, but the general opacity of the current
readahead code has been a bit of a put-off in the face of other NFS
problems.

Cheers,
  Trond

