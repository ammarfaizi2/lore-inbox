Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUEXHu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUEXHu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUEXHu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:50:27 -0400
Received: from web90001.mail.scd.yahoo.com ([66.218.94.59]:33190 "HELO
	web90001.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S261530AbUEXHuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:50:25 -0400
Message-ID: <20040524075024.84699.qmail@web90001.mail.scd.yahoo.com>
Date: Mon, 24 May 2004 00:50:24 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: Help understanding slow down
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       jakob@unthought.net, linux-kernel@vger.kernel.org
In-Reply-To: <40B1A7DE.8080309@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NO HT, disabled in bios and did not enable in kernel:
cat /proc/cpuinfo|grep processor|wc -l
  2
grep SMT .config (2.6.7-rc1)
# CONFIG_SCHED_SMT is not set

On 2.4.21 I also include "append=noht"

Thanks!
Phy



--- Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Phy Prabab wrote:
> > For more information, I ran the same test on
> 2.4.21
> 
> ...
> 
> Is hyperthreading enabled on 2.6 and 2.4? Can you
> send
> a cat /proc/cpuinfo | grep processor for a 2.4 and a
> 2.6
> kernel please?
> 
> If you have hyperthreading enabled, try 2.6.7-rc1
> with
> SMT (hyperthreading) scheduler support enabled in
> the
> kernel config. It is in processor type and features
> menu.
> 


	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
