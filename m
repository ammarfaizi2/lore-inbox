Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSECQAD>; Fri, 3 May 2002 12:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314493AbSECQAC>; Fri, 3 May 2002 12:00:02 -0400
Received: from [195.63.194.11] ([195.63.194.11]:11793 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314491AbSECQAB>; Fri, 3 May 2002 12:00:01 -0400
Message-ID: <3CD2A54E.2070404@evision-ventures.com>
Date: Fri, 03 May 2002 16:57:18 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.5.13 IDE and preemptible kernel problems
In-Reply-To: <20020503173859.A1016@averell>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Andi Kleen napisa?:
> Hi,
> 
> When booting an preemptible kernel 2.5.13 kernel on x86-64 I get 
> very quickly an scheduling in interrupt BUG. It looks like the 
> preempt_count becomes 0 inside the ATA interrupt handler. This 
> could happen when save_flags/restore_flags and friends are unmatched
> and you have too many flags restores in IDE. 

Thank you for pointing out. I will re check it.

