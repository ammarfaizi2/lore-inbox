Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132854AbQLNUNU>; Thu, 14 Dec 2000 15:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbQLNUNJ>; Thu, 14 Dec 2000 15:13:09 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:38916 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132854AbQLNUM7>; Thu, 14 Dec 2000 15:12:59 -0500
Date: Thu, 14 Dec 2000 20:43:18 +0100 (CET)
From: eduard.epi@t-online.de (Peter Bornemann)
To: Tim Waugh <twaugh@redhat.com>
cc: Peter Bornemann <eduard.epi@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: parport1 gone in 2.2.18
In-Reply-To: <20001213231332.P5918@redhat.com>
Message-ID: <Pine.LNX.4.21.0012142026150.684-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Tim Waugh wrote:
 
> The reason it works for you with modules is probably because you have
> an options line in /etc/modules.conf that tells parport_pc which
> addresses your PCI card is using at the moment.

Bad news: the old problem with lockups during insmoding parport is back! I
recompiled 2.2.18, because there is a problem with the 8138too-driver vs. 
modutils-2.3.22. Since then, the old problem was back! Unfortunately I
did not save the old modules. So, for the moment I cannot use 2.2.18 at
all and I have switched to the 2.4 series and modutils-2.3.14 (version of
modprobe doesn´t matter for the lockups, however). 

Any hint is welcome, for I would prefer a really stable kernel for this
machine.

Peter B


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
