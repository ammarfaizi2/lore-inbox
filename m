Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264471AbSIQSi6>; Tue, 17 Sep 2002 14:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264472AbSIQSi6>; Tue, 17 Sep 2002 14:38:58 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:2540 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S264471AbSIQSi4>; Tue, 17 Sep 2002 14:38:56 -0400
Message-ID: <3D87785B.1080809@drugphish.ch>
Date: Tue, 17 Sep 2002 20:45:47 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TLB flush counters gone in 2.5.35-bk?
References: <3D874DA1.20803@drugphish.ch.suse.lists.linux.kernel> <p73znugtuw4.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can easily get the same information from the CPU performance counters
> (e.g. via oprofile) 

Thanks for the pointer Andi, I should have thought of oprofile before.

You wouldn't happen to know the equivalent counter event to a 
tlb_flush_mmu() for a PIII by any chance, would you? :). I've checked 
op_help and only found the ITLB_MISS. I look at the L2_* related cpu 
counters but can't find a TLB flush counter.

I'm reading through Appendix A of the IA-32 Architecture Vol 3 manual 
(it's actually very interesting), but I haven't found it either so far. 
Do I have to check for the INVLPG instructions?

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

