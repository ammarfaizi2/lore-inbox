Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280357AbRKSR1g>; Mon, 19 Nov 2001 12:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280328AbRKSRZ5>; Mon, 19 Nov 2001 12:25:57 -0500
Received: from ids.big.univali.br ([200.169.51.11]:58241 "HELO
	mail.big.univali.br") by vger.kernel.org with SMTP
	id <S280364AbRKSRZo>; Mon, 19 Nov 2001 12:25:44 -0500
Message-Id: <5.1.0.14.1.20011119151030.00aa7788@mail.big.univali.br>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 19 Nov 2001 15:25:52 -0200
To: linux-kernel@vger.kernel.org
From: Marcus Grando <marcus@big.univali.br>
Subject: Re: remove_free_dquot: dquot not on the free list??
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi,

        I apply this patch in kernel-2.4.15-pre6,

        I use the quota-tools 3.02, and kernel its compiled with SMP.

        Probably this patch solve this problem, but its occurred randomly

        So far this problem did not occur again.

Tanks again,
Regards,

Marcus Grando

At 14:16 19/11/2001 -0200, you wrote:
>Date: Mon, 19 Nov 2001 15:04:02 +0100
>From: Jan Kara <jack@suse.cz>
>To: Marcus Grando <marcus@big.univali.br>
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: remove_free_dquot: dquot not on the free list??
>
>  Hi,
>
>>         This problem occours in 2.4.15-pre5.
>>
>>         Some ideas to solve this problem?
>  Any info about system? I suppose it's multiprocessor system. Can
>you please try attached patch? It adds a few forgotten lock_kernel()...
>Once I get at least one possitive report that it fixes the things I'll
>submit it to Linus :)
>
>                                                                Honza


