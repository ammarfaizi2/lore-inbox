Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWD0DbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWD0DbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 23:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWD0DbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 23:31:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52965 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964908AbWD0DbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 23:31:05 -0400
Date: Wed, 26 Apr 2006 20:31:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Simple header cleanups
In-Reply-To: <1146107871.2885.60.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com> 
 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org> 
 <1146105458.2885.37.camel@hades.cambridge.redhat.com> 
 <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org> <1146107871.2885.60.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Apr 2006, David Woodhouse wrote:
> 
> Agreed. And distributions and library maintainers _will_ fix them. Are
> we to deny those people the tools which will help them to keep track of
> our breakage and submit patches to fix it?

No. As mentioned, as long as the target audience is distributions and 
library maintainers, I definitely think we should do help them as much as 
possible. Our problems have historically been "random people" who have 
/usr/include/linux being the symlink to "kernel source of the day", which 
is an unsupportable situation.

(And yes, for a short while back in the early nineties, that symlink was 
even the proper thing to do. But exactly because it's unsupportable, it 
pretty quickly got to be a "don't do that then", but I still occasionally 
hear from people who use bad distributions).

		Linus
