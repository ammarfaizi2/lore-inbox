Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbVI1Peq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVI1Peq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 11:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVI1Pep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 11:34:45 -0400
Received: from main.gmane.org ([80.91.229.2]:3216 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750858AbVI1Pep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 11:34:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: bogus VIA IRQ fixup in drivers/pci/quirks.c
Date: Wed, 28 Sep 2005 17:32:57 +0200
Message-ID: <pan.2005.09.28.15.32.56.897766@free.fr>
References: <20050926184451.GB11752@suse.de> <Pine.LNX.4.58.0509261446590.3308@g5.osdl.org> <1127831274.433956ea35992@webmail.jordet.nu> <Pine.LNX.4.58.0509270734340.3308@g5.osdl.org> <1127855989.4339b77537987@webmail.jordet.nu> <Pine.LNX.4.58.0509271432490.3308@g5.osdl.org> <1127857716.4339be34f239f@webmail.jordet.nu> <Pine.LNX.4.58.0509271556211.3308@g5.osdl.org> <pan.2005.09.28.07.28.55.23717@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, 28 Sep 2005 09:28:56 +0200, Matthieu CASTET a écrit :

> Hi Linus,
> 
> Le Tue, 27 Sep 2005 15:58:33 -0700, Linus Torvalds a écrit :
> 
>> 
>> 
> 
>> so my patch didn't change anything at all for you (which is correct - it 
>> was designed not to ;)
>> 
> 
> It will for me as I have [1].
> 
> But since the irq for ide are probe after, I think it won't change
> anything.
> I will try your patch when I'll have some free time.
> 
Seem to work fine here (disable all fix).

