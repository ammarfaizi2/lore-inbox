Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272368AbRHYAn4>; Fri, 24 Aug 2001 20:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272370AbRHYAnq>; Fri, 24 Aug 2001 20:43:46 -0400
Received: from cabal.xs4all.nl ([213.84.101.140]:28652 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S272368AbRHYAng>;
	Fri, 24 Aug 2001 20:43:36 -0400
Date: Sat, 25 Aug 2001 02:43:52 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: oops in 3c59x driver
Message-ID: <20010825024352.C21339@wiggy.net>
Mail-Followup-To: Wichert Akkerman <wichert@wiggy.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010825020022.B21339@wiggy.net> <E15aR40-0006qp-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15aR40-0006qp-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Alan Cox wrote:
> Change the semaphore in drivers/pnp/pnp_bios.c to a spinlock_irqsave
> and __cli/ spin_unlock_irqrestore.  See if the crashes then go away.

That seems to have fixed it.

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
