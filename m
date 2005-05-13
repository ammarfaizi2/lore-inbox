Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVEMHox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVEMHox (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 03:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVEMHow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 03:44:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:50143 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262273AbVEMHou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 03:44:50 -0400
Date: Fri, 13 May 2005 09:44:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT and Cascade interrupts
Message-ID: <20050513074439.GB25458@elte.hu>
References: <Pine.LNX.4.44.0505120740270.31369-100000@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0505120740270.31369-100000@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> 	It seems like the cascade interrupts could run in threads, but 
> i386 doesn't, and I know ARM crashed with cascades in threads. You may 
> have a bit of a slow down, but it seems possible. Does anyone have 
> some reasoning for why we aren't running the cascades in threads?

are the x86 cascade interrupts real ones in fact? Normally they should 
never trigger directly. (except on ARM which has a completely different 
notion of cascade irq)

	Ingo
