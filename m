Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWA2B7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWA2B7b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 20:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWA2B7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 20:59:31 -0500
Received: from pat.uio.no ([129.240.130.16]:63702 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750808AbWA2B7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 20:59:30 -0500
Subject: Re: 2.6.15.1: persistent nasty hang in sync_page killing NFS
	(ne2k-pci / DP83815-related?), i686/PIII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nix <nix@esperi.org.uk>
Cc: linux-kernel@vger.kernel.org, thockin@hockin.org
In-Reply-To: <87fyn8artm.fsf@amaterasu.srvr.nix>
References: <87fyn8artm.fsf@amaterasu.srvr.nix>
Content-Type: text/plain
Date: Sat, 28 Jan 2006 20:59:17 -0500
Message-Id: <1138499957.8770.91.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.148, required 12,
	autolearn=disabled, AWL 1.67, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-28 at 22:52 +0000, Nix wrote:

> tcpdumps and the kernel's packet counters on both sides show NFS packets
> flowing, and being retried, over and over again:

Are you using an Intel motherboard? If so, it could be the IPMI bug

http://blogs.sun.com/roller/page/shepler?entry=port_623_or_the_mount

Cheers,
  Trond

