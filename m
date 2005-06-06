Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVFFHnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVFFHnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 03:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVFFHnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 03:43:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38790 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261190AbVFFHnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 03:43:50 -0400
Date: Mon, 6 Jun 2005 09:41:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT-V0.7.47-17 build fails
Message-ID: <20050606074112.GB10387@elte.hu>
References: <200506051757.26253.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506051757.26253.gene.heskett@verizon.net>
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


* Gene Heskett <gene.heskett@verizon.net> wrote:

> Greetings;
> 
> I thought maybe I'd exersize this kernel, but a patch I thought was in 
> seems not to have been, so I believe this is the 2nd time I've 
> encountered this:
> 
>   CC      drivers/char/ipmi/ipmi_devintf.o
> drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_new_smi':
> drivers/char/ipmi/ipmi_devintf.c:532: warning: passing arg 1 of 

> which of the 'git' patches fixes this?

the fix is dca79a046b93a81496bb30ca01177fb17f37ab72. I've added it to my 
tree and have uploaded the -47-18 patch.

	Ingo
