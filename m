Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVG0KGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVG0KGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 06:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVG0KGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 06:06:20 -0400
Received: from tim.rpsys.net ([194.106.48.114]:31884 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262115AbVG0KGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 06:06:18 -0400
Subject: Re: [patch] Support powering sharp zaurus sl-5500 LCD up and down
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, lenz@cs.wisc.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050727095324.GE4270@elf.ucw.cz>
References: <20050727092613.GA4713@elf.ucw.cz>
	 <20050727023754.6846f3a2.akpm@osdl.org>  <20050727095324.GE4270@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 11:06:09 +0100
Message-Id: <1122458769.7773.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 11:53 +0200, Pavel Machek wrote: 
> +	/* read comadj */
> +#ifdef CONFIG_MACH_POODLE
> +	comadj = 118;
> +#else
> +	comadj = 128;
> +#endif

Can you go back to the Sharp source and confirm that these values should
be hardcoded in both the poodle and collie cases please? I know the
sharpsl_param code can provide them but I can't remember exactly which
models use which fields. I want to make sure this isn't a quick hack
John made before sharpsl_param was written :).

Thanks,

Richard

