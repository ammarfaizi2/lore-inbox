Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbVINHgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbVINHgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 03:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVINHgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 03:36:40 -0400
Received: from colo.lackof.org ([198.49.126.79]:5840 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S965063AbVINHgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 03:36:40 -0400
Date: Wed, 14 Sep 2005 01:42:48 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Grant Grundler <grundler@parisc-linux.org>
Subject: Re: -git11 breaks parisc and sh even more
Message-ID: <20050914074248.GA21436@colo.lackof.org>
References: <20050913174754.GA13132@mipter.zuzino.mipt.ru> <20050913185759.GA17272@mars.ravnborg.org> <20050913203720.GA12868@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913203720.GA12868@mipter.zuzino.mipt.ru>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 12:37:20AM +0400, Alexey Dobriyan wrote:
> > > 2.6.13-git11
...
> > > include/asm/system.h:174: error: parse error before "pa_tlb_lock"
...
> fb1c8f93d869b34cacb8b8932e2b83d96a19d720 is first bad commit
> diff-tree fb1c8f93d869b34cacb8b8932e2b83d96a19d720 (from 4327edf6b8a7ac7dce144313947995538842d8fd)
> Author: Ingo Molnar <mingo@elte.hu>
> Date:   Sat Sep 10 00:25:56 2005 -0700
> 
>     [PATCH] spinlock consolidation

If someone can give me a recipe how to access 2.6.13-git11 source tree,
I should be able to unravel this and submit a tested patch in < 48h.
I'm pretty sure it's just an issue of parisc being slightly behind
the main tree. Ingo's patch is clearly a step in the right direction.

thanks,
grant
