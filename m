Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289116AbSAVEQu>; Mon, 21 Jan 2002 23:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289140AbSAVEQl>; Mon, 21 Jan 2002 23:16:41 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:18675 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S289116AbSAVEQh>; Mon, 21 Jan 2002 23:16:37 -0500
Subject: Re: preemption and pccard ?
To: linux-kernel@vger.kernel.org
Date: Mon, 21 Jan 2002 20:18:02 -0800 (PST)
In-Reply-To: <no.id> from "barryn" at Jan 21, 2002 01:42:49 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020122041802.8E8208954D@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Oops, I think I sent this via private mail last time, instead of to the
list.)

I've also seen problems with the preempt patch and PCMCIA/CardBus, on my
Dell Inspiron 5000e. The top CardBus slot doesn't work for me with the
preemption patch (in fact, if I have a card in there, sometimes the
machine freezes at the point in boot when it would normally detect the
card). It usually doesn't even see that I've put a card in there. I don't
remember trying the bottom slot instead of the top though.

I just never got a chance to report the problem, until now. This has
happened with a range of kernels (I think I first tried the preempt patch
back around 2.4.14pre and I last tried it with a late 2.4.17-pre or with
2.4.17-rc1.)

-Barry K. Nathan <barryn@pobox.com>
