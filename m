Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSK3X3Z>; Sat, 30 Nov 2002 18:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSK3X3Z>; Sat, 30 Nov 2002 18:29:25 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:18819 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S261317AbSK3X3Y>;
	Sat, 30 Nov 2002 18:29:24 -0500
Date: Sun, 1 Dec 2002 00:36:47 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.20-jam0
Message-ID: <20021130233647.GA6294@werewolf.able.es>
References: <20021129233807.GA1610@werewolf.able.es> <20021130175048.GF28164@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021130175048.GF28164@dualathlon.random>; from andrea@suse.de on Sat, Nov 30, 2002 at 18:50:48 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.11.30 Andrea Arcangeli wrote:
>On Sat, Nov 30, 2002 at 12:38:07AM +0100, J.A. Magallon wrote:
>> - reverted the fast-pte part of -aa. Still have to try again
>>   to see if it is more stable now.
>
>AFIK this was reproduced by Srihari on nohighmem so it must be that
>somebody is calling pgd_free_fast on a pgd that cannot be re-used.
>Can you try this patch on top of 2.4.20rc2aa1? (or jam0 after backing
>out the fast-pte removal that would otherwise forbid the debugging check
>to trigger)
>

Yes, I will try. Hope I use the piece of kernel that triggers this.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam1 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
