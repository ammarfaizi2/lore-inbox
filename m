Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVDRI7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVDRI7I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 04:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVDRI7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 04:59:08 -0400
Received: from mx1.suse.de ([195.135.220.2]:8385 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261980AbVDRI7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 04:59:04 -0400
Date: Mon, 18 Apr 2005 10:59:00 +0200
From: Andi Kleen <ak@suse.de>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@redhat.com, davem@davemloft.net, ak@suse.de
Subject: Re: [RFC][PATCH 0/4] AES assembler implementation for x86_64
Message-ID: <20050418085900.GD8511@wotan.suse.de>
References: <4262B6D4.30805@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4262B6D4.30805@domdv.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Microbenchmark:
> ===============
> The microbenchmark was done in userspace with similar compile flags as
> used during kernel compile.
> Encrypt/decrypt is about 35% faster than the generic C implementation.
> As the generic C as well as my assembler implementation are both table
> driven I don't really expect that there is much room for further
> improvements though I'll be glad to be corrected here.

On what CPUs did you benchmark? I suppose results will vary a lot
between AMD and Intel x86-64 CPUs.

-Andi
