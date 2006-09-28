Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbWI1LF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWI1LF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbWI1LF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:05:59 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7578 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965311AbWI1LF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:05:58 -0400
Subject: Re: [PATCH] device_for_each_child(): kill pointless warning noise
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <451B2A58.9010603@garzik.org>
References: <20060928010518.GA25865@havoc.gtf.org>
	 <20060927184200.7d7b9cc2.akpm@osdl.org>  <451B2A58.9010603@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Sep 2006 12:30:30 +0100
Message-Id: <1159443030.11049.409.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-27 am 21:50 -0400, ysgrifennodd Jeff Garzik:
> "almost all"  Thus it is wrong to _force_ the usage model on the caller.
> 
> It should be obvious that a simple search need not _require_ a dummy 
> return value, that is promptly ignored.

How about just adding an explicit device_for_each_child_noret() or
similar function so that the safety check stays as well for the usual
case.

Alan
