Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWIKQfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWIKQfP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWIKQfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:35:15 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:961 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S964893AbWIKQfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:35:14 -0400
Message-ID: <45059039.2010001@free.fr>
Date: Mon, 11 Sep 2006 18:35:05 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.5) Gecko/20060405 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [patch] i386-PDA, lockdep: fix %gs restore
References: <20060908011317.6cb0495a.akpm@osdl.org> <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu> <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911052527.GA12301@elte.hu> <20060911054620.GA15053@elte.hu>
In-Reply-To: <20060911054620.GA15053@elte.hu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 11.09.2006 07:46, Ingo Molnar a écrit :
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
>> Jeremy,
> 
> Laurent that is ...
> 
>> could you back out Andi's patch and try the patch below, does it fix the 
>> crash too?

Sorry for the late answer, I had to go to work ;-).

So 2.6.18-rc6-mm1 + hotfixes + Ingo's "i386-PDA, lockdep: fix %gs restore" 
does work well.

Thanks
-- 
laurent
