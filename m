Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272003AbRIIPb0>; Sun, 9 Sep 2001 11:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271998AbRIIPbG>; Sun, 9 Sep 2001 11:31:06 -0400
Received: from nef.ens.fr ([129.199.96.32]:53253 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S271997AbRIIPbD>;
	Sun, 9 Sep 2001 11:31:03 -0400
Date: Sun, 9 Sep 2001 17:31:15 +0200
From: =?ISO-8859-1?Q?=C9ric?= Brunet <ebrunet@quatramaran.ens.fr>
Message-Id: <200109091531.f89FVFx18487@quatramaran.ens.fr>
To: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
Subject: Re: Two bugs: PCMCIA doesn't work and bad DMA/APM interaction
In-Reply-To: <m15flku-000QFYC@amadeus.home.nl>
In-Reply-To: <20010908190133.B5716@serifos.unige.ch> <m15flku-000QFYC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-kernel, you wrote:
>
>that's because you need the "yenta_socket.o" module for cardbus!

Thanks a lot, it works beautifully with this module. I hadn't noticed
that hte module had changed between the 2.2 and 2.4 kernels, and I was
further confused by the fact that the i82365 sort of half worked with the
2.4.2...

So, now, any idea about my problem with APM and DMA disk transfers ?

Éric Brunet
