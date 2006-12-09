Return-Path: <linux-kernel-owner+w=401wt.eu-S1757214AbWLIVec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214AbWLIVec (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757265AbWLIVec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:34:32 -0500
Received: from www.osadl.org ([213.239.205.134]:48838 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757086AbWLIVeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:34:31 -0500
Subject: Re: 2.6.19-rt11 boot failure
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       linux-rt-users@vger.kernel.org
In-Reply-To: <60535.192.168.1.8.1165699722.squirrel@www.rncbc.org>
References: <60535.192.168.1.8.1165699722.squirrel@www.rncbc.org>
Content-Type: text/plain
Date: Sat, 09 Dec 2006 22:37:55 +0100
Message-Id: <1165700275.24604.350.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-09 at 21:28 +0000, Rui Nuno Capela wrote:
> Hi all,
> 
> Sorry for the interrupt, but all my 2.6.19-rt11 builds very fail early on
> boot. It doesn't matter if its UP or SMP. This is a sample of what I could
> capture on one case via serial console:

Can you please disable CONFIG_HPET_TIMER ?

	tglx


	

