Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVBQID2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVBQID2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 03:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVBQID2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 03:03:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:656 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262120AbVBQIDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 03:03:18 -0500
Date: Thu, 17 Feb 2005 09:03:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Frank Rowand <frowand@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Realtime preempt support for PPC
Message-ID: <20050217080304.GA21887@elte.hu>
References: <200502162056.j1GKuIkt005783@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502162056.j1GKuIkt005783@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Frank Rowand <frowand@mvista.com> wrote:

> I have attached a patch to add realtime support for PowerPC (32 bit
> only). [...]

two comments:

- why is us_to_tb needed? It just seems to add alot of unnecessary
  clutter to the patch, while it's not used anywhere.

- could you submit the drivers/net/ibm_emac/ibm_emac_core.c patch
  upstream as well?

otherwise it looks pretty clean and straightforward.

	Ingo
