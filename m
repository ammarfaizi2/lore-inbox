Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbTDQTQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTDQTQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:16:46 -0400
Received: from relay.pair.com ([209.68.1.20]:41990 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261897AbTDQTQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:16:45 -0400
X-pair-Authenticated: 64.211.218.23
Subject: Re: [patch] VMnet/VMware workstation 4.0
From: Daniel Gryniewicz <dang@fprintf.net>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Lucas Correia Villa Real <lucasvr@gobolinux.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <D79F957BFD@vcnet.vc.cvut.cz>
References: <D79F957BFD@vcnet.vc.cvut.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1050607717.2477.9.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 17 Apr 2003 15:28:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-17 at 14:12, Petr Vandrovec wrote:
> On 17 Apr 03 at 13:48, Lucas Correia Villa Real wrote:
> 
> > Is there a "correct" place at vmware.com to send these patches? I tryied 
> > sending it to feature-request@vmware.com, but I got no response from them. 
> > 
> > Anyway, below follows the patch providing support to devfs on the vmnet driver 
> > for vmware workstation 4.0. 
> 
> You can send them to me if you do not trust feature-request...
> 
> Proble with your patch is that it does not look like that it will
> build on 2.2.x without complaints, but I can fix that. More important
> question to me is: do people really use devfs? 
> 
> And if change will not make into next WS release, I can always distribute it
> from my site.
>                                                 Petr Vandrovec

Gentoo uses devfs, and some people (like me) use VMware on gentoo.  Not
that this matters, because the vmware startup files make the correct
device nodes.  (I've never used vmware on non-devfs but I assumed it
works fine there.)

Daniel
-- 
Daniel Gryniewicz <dang@fprintf.net>

