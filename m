Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVHAIuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVHAIuO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 04:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVHAIuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 04:50:13 -0400
Received: from NAT.office.mind.be ([62.166.230.82]:42142 "EHLO
	NAT.office.mind.be") by vger.kernel.org with ESMTP id S261666AbVHAIuM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:50:12 -0400
Date: Mon, 1 Aug 2005 10:50:04 +0200
From: Jan Veldeman <jan.veldeman@advalvas.be>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: domen@coderock.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/5] Driver core: Documentation: use snprintf and strnlen
Message-ID: <20050801085004.GA25253@eros.intern.mind.be>
References: <20050731111213.636613000@homer> <200507312025.54600.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507312025.54600.ioe-lkml@rameria.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Ingo Oeser wrote:

> On Sunday 31 July 2005 13:12, domen@coderock.org wrote:
> > From: Jan Veldeman <jan@mind.be>
> > Documentation should give the good example of using snprintf and
> > strnlen in stead of sprintf and strlen.
> > 
> > PAGE_SIZE is used as the maximal length to reflect the behaviour of
> > show/store.
> 
> The whole part of the Documentation is obsoleted by the fact,
> that struct device has no structure member called "name".
> 
> People hacking sysfs should also try to hack the docu to match or
> at least remove the obsolete parts of it.
> 
> So you can drop this patch altogether, I think.
> 
> 

Even though the example doesn't work (the comment below the example even
indicates it shouldn't be done), I would suggest to still apply this
patch, as it shows the good usage of snprintf in stead of sprintf:

Somebody who looks at the documentation will certainly change the
contents of the attribute (this is by all means the reason for such an
example), but will not likely change the way sprintf is used.

Best regards,
Jan


