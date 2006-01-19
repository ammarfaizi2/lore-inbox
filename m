Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbWASAtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbWASAtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWASAtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:49:05 -0500
Received: from pat.uio.no ([129.240.130.16]:60075 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161119AbWASAtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:49:03 -0500
Subject: Re: Can you specify a local IP or Interface to be used on a per
	NFS mount basis?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43CECB00.40405@candelatech.com>
References: <43CECB00.40405@candelatech.com>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 19:48:47 -0500
Message-Id: <1137631728.13076.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.727, required 12,
	autolearn=disabled, AWL 1.09, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 15:10 -0800, Ben Greear wrote:
> Hello!
> 
> Is there any way to specify what local IP address an NFS
> client uses to mount an NFS server?
> 
> For instance, if I have eth0 with IP 192.168.1.6 and eth1
> with IP 192.168.1.7, how can I make sure that a particular
> mount point is accessed via 192.168.1.7?

NFS doesn't know anything about ip packet routing. That is a networking
issue.

Cheers,
  Trond

