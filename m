Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279785AbRKAVX2>; Thu, 1 Nov 2001 16:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279786AbRKAVXT>; Thu, 1 Nov 2001 16:23:19 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.34]:962 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S279785AbRKAVXM>; Thu, 1 Nov 2001 16:23:12 -0500
Date: Thu, 1 Nov 2001 22:23:10 +0100 (CET)
From: Dirk Moerenhout <dirk@staf.planetinternet.be>
X-X-Sender: <dmoerenh@dirk>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: graphical swap comparison of aa and rik vm
In-Reply-To: <Pine.LNX.4.10.10111010056100.31484-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0111012215480.608-100000@dirk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> also, if you merely sum the SI and SO columns for each:
> 		sum(SI)		sum(SO)		sum(SI+SO)
>       Rik-VM	43564		317448		290032
>       AA-VM	118284		171748		361012
> to me, this looks like the same point: Rik being SO-happy,
> Andrea having to SI a lot more.  interesting also that Andrea wins the race,
> in spite of poorer SO choices and more swap traffic overall.

Just cause I didn't see anybody mentioned it yet: your statement is not
valid you switched the SI+SO values. It's 361012 for Rik-VM and 290032 for
AA-VM (easy to see as SO for Rik-VM is higher than the sum for Rik-VM in
your table ;-) ). So AA makes less swap traffic overall which does
actually explain at least partially why it wins the race.

Regards,

Dirk Moerenhout ///// System Administrator ///// Planet Internet NV

