Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135547AbRDXLhU>; Tue, 24 Apr 2001 07:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135548AbRDXLhK>; Tue, 24 Apr 2001 07:37:10 -0400
Received: from mta05.mail.au.uu.net ([203.2.192.85]:50842 "EHLO
	mta05.mail.mel.aone.net.au") by vger.kernel.org with ESMTP
	id <S135547AbRDXLhE>; Tue, 24 Apr 2001 07:37:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Matt Johnston <lkm-stuff@caifex.org>
To: linux-kernel@vger.kernel.org
Subject: Re: odd messages in dmesg (network I think)
Date: Tue, 24 Apr 2001 19:39:34 +0800
X-Mailer: KMail [version 1.2.1]
In-Reply-To: <3AE4BBAA.C5A91413@internet.com>
In-Reply-To: <3AE4BBAA.C5A91413@internet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010424113700.SFAM10022.mta05.mail.mel.aone.net.au@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed the same for 2.4.x kernels for quite a while back.... The first 
appearence in logs/kernel is for 2.4.2-ac17.

Afaik I haven't noticed any resultant problems so I presume its just some 
over-informative debugging code??

Cheers,
Matt Johnston.

On Tue, 24 Apr 2001 07:32, Byron Albert wrote:
> Hello,
>  I am getting odd message in my dmesg
> I am running
> Linux extreme 2.4.2-ac28 #1 SMP Fri Apr 13 01:58:47 UTC 2001 i686
> unknown
> and the messages look like
>
>
> Undo Hoe 64.22.x.x/4414 c3 l2 ss10/65535 p4
> Undo Hoe 64.22.x.x/4414 c3 l1 ss10/65535 p3
> Undo Hoe 64.22.x.x/4414 c3 l1 ss10/65535 p2
> Undo retrans 64.22.x.x/4414 c2 l0 ss10/65535 p0
> Undo partial loss 64.157.x.x/32831 c1 l1 ss2/65535 p1
> Disorder3 1 4 f4 s2 rr0
> Disorder3 1 4 f4 s2 rr0
> Disorder3 1 4 f4 s2 rr0
> Undo loss 64.108.x.x/2786 c2 l0 ss2/65535 p0
> Undo partial loss 200.27.x.x/2374 c1 l1 ss2/65535 p1
> Undo partial loss 213.228.x..x/32936 c2 l1 ss2/65535 p1
> Undo partial loss 213.228.x.x/32937 c2 l1 ss2/65535 p1
> Disorder3 3 5 f6 s2 rr0
> Disorder1 3 6 f0 s0 rr1
> Undo Hoe 202.75.x.x/34237 c7 l0 ss4/65535 p6
> Undo Hoe 202.75.x.x/34237 c7 l0 ss4/65535 p5
> Undo retrans 202.75.x.x/34237 c6 l0 ss4/65535 p5
>
> On my webserver errors like this fill the dmesg in a day. I did repalce
> some ips with x.x.
>
> Thanks for any info
> Byron
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
