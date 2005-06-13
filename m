Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVFMO6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVFMO6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 10:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVFMO6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 10:58:05 -0400
Received: from mx1.elte.hu ([157.181.1.137]:14488 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261591AbVFMO6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 10:58:02 -0400
Date: Mon, 13 Jun 2005 16:51:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RT and kernel debugger ( 2.6.12rc6  + RT  > 48-00 )
Message-ID: <20050613145154.GA5822@elte.hu>
References: <1118673083.10717.83.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118673083.10717.83.camel@ibiza.btsn.frna.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> 	I would like to know what kernel debugger you propose over the 
> RT patch. I used to test kgdb, but since spinlock modification, it 
> doesn't work anymore.
> 
> Does someone work over RT to port a kernel debugger ?

someone had kgdb working - but i'm not using it myself. IIRC it was 
mostly an issue of changing the proper spinlocks to raw_spinlock_t.

	Ingo
