Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUJFE55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUJFE55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 00:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUJFE55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 00:57:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:51419 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266793AbUJFE54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 00:57:56 -0400
Date: Tue, 5 Oct 2004 21:46:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: andrea@novell.com, nickpiggin@yahoo.com.au, rml@novell.com,
       roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive
 (SCSI-libsata, VIA SATA))
Message-Id: <20041005214605.5ec397ab.akpm@osdl.org>
In-Reply-To: <41636FCF.3060600@pobox.com>
References: <52is9or78f.fsf_-_@topspin.com>
	<4163465F.6070309@pobox.com>
	<41634A34.20500@yahoo.com.au>
	<41634CF3.5040807@pobox.com>
	<1097027575.5062.100.camel@localhost>
	<20041006015515.GA28536@havoc.gtf.org>
	<41635248.5090903@yahoo.com.au>
	<20041006020734.GA29383@havoc.gtf.org>
	<20041006031726.GK26820@dualathlon.random>
	<4163660A.4010804@pobox.com>
	<20041006040323.GL26820@dualathlon.random>
	<41636FCF.3060600@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Preempt will always be something I ask people to turn off when reporting 
>  driver bugs; it just adds too much complicated mess for zero gain.

What driver bugs are apparent with preemption which are not already SMP bugs?

Only thing I can think of is unguarded use of per-cpu data, and we have
runtime debug checks for that now.

