Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266247AbUFUOPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266247AbUFUOPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 10:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266241AbUFUOPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 10:15:18 -0400
Received: from amazonas-2333.adsl.datanet.hu ([195.56.231.47]:33824 "HELO gw")
	by vger.kernel.org with SMTP id S266247AbUFUOPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 10:15:08 -0400
Date: Mon, 21 Jun 2004 16:15:06 +0200
From: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 shows K7 with Pentium Pro erratum [Re: New version of early CPU detect] II
Message-ID: <priv$1087826841.koan@noc.xeon.eu.org>
Mail-Followup-To: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
	Andi Kleen <ak@suse.de>, akpm@osdl.org, manfred@colorfullife.com,
	linux-kernel@vger.kernel.org
References: <20040423043001.4bb05d5f.ak@suse.de> <20040621120416.GA2722@noc.xeon.eu.org> <20040621173155.74982100.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040621173155.74982100.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-06-21 at 17:31:55, Andi Kleen wrote:
> Please ignore the previous patch I sent. This patch should actually fix it.

> +++ linux-2.6.7-work/arch/i386/kernel/cpu/common.c	2004-06-21 17:30:57.000000000 +0200
...
> @@ -483,6 +482,7 @@
>  	rise_init_cpu();
>  	nexgen_init_cpu();
>  	umc_init_cpu();
> +	early_cpu_detect();


Yup, it does!  Thanks!

-- 
Janos | romfs is at http://romfs.sourceforge.net/ | Don't talk about silence.
