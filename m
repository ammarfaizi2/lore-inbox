Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVCNUAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVCNUAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVCNUAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:00:00 -0500
Received: from mail.aknet.ru ([217.67.122.194]:7945 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261281AbVCNT7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:59:39 -0500
Message-ID: <4235ED35.1000405@aknet.ru>
Date: Mon, 14 Mar 2005 22:59:49 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [patch] x86: fix ESP corruption CPU bug (take 2)
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz> <4234A8DD.9080305@aknet.ru> <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org> <4234B96C.9080901@aknet.ru> <20050314192943.GG18826@devserv.devel.redhat.com>
In-Reply-To: <20050314192943.GG18826@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Alan Cox wrote:
>> Alan, can you please apply that to an -ac
>> tree?
> Ask Andrew Morton as it belongs in the -mm tree
Actually I tried that already. Andrew
had nothing against that patch personally,
as well as Linus, but after all that didn't
work:
http://lkml.org/lkml/2005/1/3/260

So it can't be applied to -mm, and not
depending on the kgdb-ga patch allowed for
some extra optimization.
So I have to try the -ac as the last resort.
I realized you won't be pleased with that
too much. If you are confident it doesn't
fit the -ac tree by whatever means, I can
understand that. (In that case I'll much
appreciate the suggestion what other tree
should I try.)

