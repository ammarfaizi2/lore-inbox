Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316051AbSHBPzW>; Fri, 2 Aug 2002 11:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSHBPzW>; Fri, 2 Aug 2002 11:55:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17170 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316051AbSHBPyh>; Fri, 2 Aug 2002 11:54:37 -0400
Date: Fri, 2 Aug 2002 08:59:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@suse.de>
cc: davidm@hpl.hp.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, <davidm@napali.hpl.hp.com>
Subject: Re: adjust prefetch in free_one_pgd()
In-Reply-To: <20020802175608.O25761@suse.de>
Message-ID: <Pine.LNX.4.44.0208020859060.18265-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, Dave Jones wrote:
> On Fri, Aug 02, 2002 at 08:46:38AM -0700, Linus Torvalds wrote:
>
>  > Personally, I would just say that we should disable prefetch on such
>  > clearly broken hardware, but since it's Alans favourite machine (some
>  > early AMD Athlon if I remember correctly), I think Alan will disagree ;)
>
> I think I now understand why you silently dropped the 'disable broken hw
> prefetch on early stepping P4' patch I sent you. 8-)

No, I don't think either I (nor Alan) has any early stepping P4's.

Me dropping patches is just normal ;)

		Linus

