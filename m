Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137097AbREKKgd>; Fri, 11 May 2001 06:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137099AbREKKgW>; Fri, 11 May 2001 06:36:22 -0400
Received: from ns.suse.de ([213.95.15.193]:2564 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S137097AbREKKgF>;
	Fri, 11 May 2001 06:36:05 -0400
Date: Fri, 11 May 2001 12:32:57 +0200
From: Andi Kleen <ak@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Andi Kleen <ak@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Source code compatibility in Stable series????
Message-ID: <20010511123257.A6023@gruyere.muc.suse.de>
In-Reply-To: <2983F527D00@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <2983F527D00@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Fri, May 11, 2001 at 12:21:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 12:21:59PM +0000, Petr Vandrovec wrote:
> When I was updating VMware's vmnet, I decided to use
> 
> #ifdef skb_shinfo

Yes I forgot that RedHat already shipped it :-(

> This gives you maximal backward compatibility, as all public zerocopy
> patches contain this macro. Only thing is that Dave has to remember
> that when he turns skb_shinfo into inline function, an identity #define have
> to be added.

No such guarantee for binary only software ;)

-Andi
