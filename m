Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUJFBdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUJFBdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUJFBdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:33:36 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:49586 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266627AbUJFBdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:33:35 -0400
Message-ID: <41634B3B.8050403@yahoo.com.au>
Date: Wed, 06 Oct 2004 11:32:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au>
In-Reply-To: <41634A34.20500@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> With preempt, sure you still need small lock hold times. No big
> deal.

*Making* the lock hold times small is a big deal as Ingo will
attest ;)

But I mean "no big deal" as in, it has to be done whether or not
you have preempt.
