Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUJFBwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUJFBwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUJFBwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:52:54 -0400
Received: from peabody.ximian.com ([130.57.169.10]:52705 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266680AbUJFBwp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:52:45 -0400
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive
	(SCSI-libsata, VIA SATA))
From: Robert Love <rml@novell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Roland Dreier <roland@topspin.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <41634CF3.5040807@pobox.com>
References: <4136E4660006E2F7@mail-7.tiscali.it>
	 <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com>
	 <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au>
	 <41634CF3.5040807@pobox.com>
Content-Type: text/plain
Date: Tue, 05 Oct 2004 21:52:55 -0400
Message-Id: <1097027575.5062.100.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 21:40 -0400, Jeff Garzik wrote:

> And with preempt you're still hiding stuff that needs fixing.  And when 
> it gets fixed, you don't need preempt.
> 
> Therefore, preempt is just a hack that hides stuff that wants fixing anyway.

This actually sounds like the argument for preempt, and against
sprinkling cond_resched() hacks all over the kernel.

	Robert Love


