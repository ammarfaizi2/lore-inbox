Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVILR76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVILR76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVILR76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:59:58 -0400
Received: from pc1058.sks3.muni.cz ([147.251.210.58]:50129 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S1750784AbVILR75
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:59:57 -0400
Date: Mon, 12 Sep 2005 20:00:39 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops 2.6.13-git6
Message-ID: <20050912180038.GE2382@mail.muni.cz>
References: <20050912102011.GA2379@mail.muni.cz> <1126530670.30449.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1126530670.30449.64.camel@localhost.localdomain>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 02:11:10PM +0100, Alan Cox wrote:
> The 2.6 IDE layer doesn't support IDE drive hot or warm plug. 2.4-ac did
> but that was the only one that ever supported it.
> 
> Nevertheless it should not have crashed only errored so the bug report
> is useful 8)

However, in the case of 2 IDE channels hotplug program works with unregister and
rescan commands. I think there is still problem with DMA, but it works partly.

Another issue, when cdrecord finalizes DVD or CD, then whole IDE channel is
blocked. Is that hardware problem or some preemption problem in kernel?

-- 
Luká¹ Hejtmánek
