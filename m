Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265534AbUFIElT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265534AbUFIElT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 00:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbUFIElS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 00:41:18 -0400
Received: from gizmo01bw.bigpond.com ([144.140.70.11]:28314 "HELO
	gizmo01bw.bigpond.com") by vger.kernel.org with SMTP
	id S265534AbUFIElN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 00:41:13 -0400
Message-ID: <40C694E3.7030509@bigpond.net.au>
Date: Wed, 09 Jun 2004 14:41:07 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: slow down in 2.6 vs 2.4
References: <1086744927.40c6695f9c361@vds.kolivas.org>
In-Reply-To: <1086744927.40c6695f9c361@vds.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Hi Phy
> 
> You said:
> Over the last two days I have been struggling with
> understanding why 2.6.x kernel is slower than
> 2.4.21/23 kernels.  I think I have a test case which
> demostrates this issue.
> make times:
> 
> 2.4.21:
> 323.68user 56.07system 6:35.77elapsed 95%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (3138783major+3818347minor)pagefaults
> 0swaps
> 
> 2.6.7-rc3-s63 (SPA scheduler):
> 334.01user 69.86system 7:01.47elapsed 95%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (13301major+6931745minor)pagefaults
> 0swaps
> 
> 2.6.7-rc3:
> 336.17user 68.41system 7:02.47elapsed 95%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (13301major+6931745minor)pagefaults
> 0swaps
> 
> 
> ----
> Your 2.4 compile is showing a massive number of major page faults.

Seems to be roughly the same total number of page faults in all three 
cases but there's been a big shift from majors to minors for the 2.6 
kernels which I would have thought would improve performance?

Peter
-- 
Dr Peter Williams                                pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

