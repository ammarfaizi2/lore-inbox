Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262283AbREUAiF>; Sun, 20 May 2001 20:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262284AbREUAhz>; Sun, 20 May 2001 20:37:55 -0400
Received: from are.twiddle.net ([64.81.246.98]:8710 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262283AbREUAhp>;
	Sun, 20 May 2001 20:37:45 -0400
Date: Sun, 20 May 2001 17:37:28 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010520173728.A19096@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519181127.A14645@twiddle.net> <20010520160518.A8223@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010520160518.A8223@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Sun, May 20, 2001 at 04:05:18PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 04:05:18PM +0400, Ivan Kokshaysky wrote:
> Ok. What do you think about reorg like this:
> basically leave the old code as is, and add
>         if (is_pyxis)
>                 alpha_mv.mv_pci_tbi = cia_pci_tbi_try2;
>         else
>                 tbia test
>                 ...

Seems good.

> 21174 docs confirm that (though in a very low voice ;-) :
>  "The 21174 may hang with TBIA=3."

Mmm.  Tasty.  :-)


r~
