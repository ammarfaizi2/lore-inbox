Return-Path: <linux-kernel-owner+w=401wt.eu-S1161311AbXAHOCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161311AbXAHOCH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 09:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161310AbXAHOCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 09:02:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:52143 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161311AbXAHOCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 09:02:06 -0500
Date: Mon, 8 Jan 2007 14:56:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] simplify the stacktrace code
Message-ID: <20070108135622.GA11715@elte.hu>
References: <20070108135128.GA23152@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108135128.GA23152@lst.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@lst.de> wrote:

> Simplify the stacktrace code:
> 
>  - remove the unused task argument to save_stack_trace, it's always
>    current
>  - remove the all_contexts flag, it's alwasy 0
                                            ^---- typo
looks good to me - thanks for the cleanup.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
