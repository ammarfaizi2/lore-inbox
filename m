Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUFVHzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUFVHzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 03:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUFVHzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 03:55:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7390 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261234AbUFVHzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 03:55:13 -0400
Date: Tue, 22 Jun 2004 09:56:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Keith Owens <kaos@sgi.com>
Cc: Takao Indoh <indou.takao@soft.fujitsu.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040622075623.GA16829@elte.hu>
References: <20040617121356.GA24338@elte.hu> <1642.1087796771@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642.1087796771@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Keith Owens <kaos@sgi.com> wrote:

> Don't forget live crash dumping. [...]

it's still possible, you'll have to save/restore the timer table,
instead of overwriting it.

	Ingo
