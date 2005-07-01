Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263410AbVGATeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263410AbVGATeV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbVGATeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:34:21 -0400
Received: from smtp-3.llnl.gov ([128.115.41.83]:65161 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S263410AbVGATeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:34:16 -0400
Date: Fri, 01 Jul 2005 12:34:13 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-reply-to: <20050701071850.GA18926@elte.hu>
To: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.63.0507011220280.5411@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2005, Ingo Molnar wrote:

>
> * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
>
>> Ooops, you didn't apply this part of the patch:
>
> oops - i had it in my tree (so all my tests passed), but it escaped the
> -39 patch. I've uploaded -50-40 with this included too.
>
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Well, the -50-42 still has the problem with sox locking up too tightly to
kill. Just saw that the sox processes are all in state 'D', FWIW.

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- Bad breath is better than no breath. --
