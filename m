Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316895AbSGSQzn>; Fri, 19 Jul 2002 12:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSGSQzn>; Fri, 19 Jul 2002 12:55:43 -0400
Received: from jalon.able.es ([212.97.163.2]:59128 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316895AbSGSQzm>;
	Fri, 19 Jul 2002 12:55:42 -0400
Date: Fri, 19 Jul 2002 18:58:22 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1
Message-ID: <20020719165822.GA1690@werewolf.able.es>
References: <20020717225504.GA994@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020717225504.GA994@dualathlon.random>
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.18 Andrea Arcangeli wrote:
>I would appreciate any feedback on the last patches for the i_size
>atomic accesses on 32bit archs. Thanks,
>
>URL:
>
>	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc2aa1.gz
>	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc2aa1/
>
>diff between 2.4.19rc1aa2 and 2.4.19rc1aa2:
>
>Only in 2.4.19rc1aa2: 000_e100-2.0.30-k1.gz
>Only in 2.4.19rc2aa1: 000_e100-2.1.6.gz
>Only in 2.4.19rc1aa2: 000_e1000-4.2.17-k1.gz
>Only in 2.4.19rc2aa1: 000_e1000-4.3.2.gz
>
>	Upgrade to latest drivers to see if they fix the reports.

Any decent changelog for this two ? Docs in intel's website and downloadable
packages say just nothing.

And look interesting. I am running 2.4.19-rc2-jam1 on the cluster and NetPipe
performance jumped from 400 to 500 Mbits/sec (ie, 100Mb just for free).

Ehem, new kernel also included smptimers, so it is really the mix what
improves throughput. Anyone can say if the scalable timers can influence
network performance ??

TIA

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc2-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.8mdk)
