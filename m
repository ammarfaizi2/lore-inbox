Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWECUdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWECUdZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWECUdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:33:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31906 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750816AbWECUdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:33:25 -0400
Date: Wed, 3 May 2006 22:38:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, dvhltc@us.ibm.com
Subject: Re: [RFC][PATCH -rt] Make futex_wait() use an hrtimer for timeout
Message-ID: <20060503203803.GA15414@elte.hu>
References: <20060412114243.42351c35@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060412114243.42351c35@frecb000686>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sébastien Dugué <sebastien.dugue@bull.net> wrote:

>   This patch modifies futex_wait() to use an hrtimer + schedule() in 
> place of schedule_timeout() in an RT kernel.

nice patch! Applied.

	Ingo
