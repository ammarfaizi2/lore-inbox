Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbUDZTE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUDZTE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 15:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbUDZTE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 15:04:57 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:26761 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263366AbUDZTEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 15:04:55 -0400
Subject: Re: 2 NFS problems
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Stanley, Jon" <Jon.Stanley@savvis.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B33FD3ADBD7054DB410CD9DA314133E775E21@sl6exch4>
References: <3B33FD3ADBD7054DB410CD9DA314133E775E21@sl6exch4>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083006294.10733.32.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Apr 2004 15:04:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-24 at 20:28, Stanley, Jon wrote:
> I have two distinct problems possibly related to NFS in the Linux
> kernel.  Any assistance would be appreciated, any flames that say "you
> should have looked such-and-such place" are welcome as well, so long as
> they include pointers to said places :-)
> 
> 1)  A system will become unusable, with the following in
> /var/log/messages:
> 
> Apr 24 22:16:35 <hostname> kernel: __alloc_pages: 4-order allocation
> failed.
> Apr 24 22:16:35 <hostname> kernel: __alloc_pages: 4-order allocation
> failed.

Sorry. NFS does not do anything more than order 1 page allocations
(unless you are talking about the server - but that only does it at
startup).

Cheers,
  Trond
