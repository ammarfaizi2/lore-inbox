Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbVJAVWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVJAVWw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 17:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVJAVWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 17:22:52 -0400
Received: from smtpout5.uol.com.br ([200.221.4.196]:19138 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1750854AbVJAVWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 17:22:51 -0400
Date: Sat, 1 Oct 2005 18:22:47 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Grant Coady <grant_lkml@dodo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051001212247.GC6397@ime.usp.br>
Mail-Followup-To: Ondrej Zary <linux@rainbow-software.org>,
	Grant Coady <grant_lkml@dodo.com.au>, linux-kernel@vger.kernel.org
References: <20050927111038.GA22172@ime.usp.br> <9ncij11fqb4l70qrhb0a8nri5moohnkaaf@4ax.com> <43393E76.2050008@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43393E76.2050008@rainbow-software.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ondrej and others,

On Sep 27 2005, Ondrej Zary wrote:
> I have a Socket 7 board somewhere with bad L2 cache - it was unstable
> but memtest was unable to find anything.

Right.

> However, GoldMemory found some errors - they disappeared after
> disabling L2 cache and crashes disappeared too.

I have not yet tried disabling the cache on my case (since both L1 and
L2 caches here are integrated into the processor). May be a possibility,
though.

> It's not free but at least shareware - you can find it at
> http://www.goldmemory.cz/

Thank you very much for this hint. It indeed found problems that
memtest86+ didn't find. I think that it would be nice to have some of
those tests integrated in memtest86+.


Thanks again,

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
