Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131755AbQKAW6W>; Wed, 1 Nov 2000 17:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131748AbQKAW6L>; Wed, 1 Nov 2000 17:58:11 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:56075 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S131734AbQKAW6E>; Wed, 1 Nov 2000 17:58:04 -0500
Date: Wed, 1 Nov 2000 23:57:34 +0100
From: Kurt Garloff <garloff@suse.de>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Message-ID: <20001101235734.D10585@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"J . A . Magallon" <jamagallon@able.es>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001101234058.B1598@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001101234058.B1598@werewolf.able.es>; from jamagallon@able.es on Wed, Nov 01, 2000 at 11:40:58PM +0100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 11:40:58PM +0100, J . A . Magallon wrote:
> I have noticed that in latest patch for 2.4.0, the global Makefile
> no more tries to find a kgcc, and falls back to gcc.
> I suppose because 2.7.2.3 is no more good for kernel, but still you
> can use 2.91, 2.95.2 or 2.96(??). Is that a patch that leaked in
> the way to test10, or is for another reason ?.

kgcc is a redhat'ism. They invented this package because their 2.96 fails
compiling a stable kernel.
However, it's not a good idea to dist specific code into the official kernel
tree.

Regards,
-- 
Kurt Garloff                <kurt@garloff.de>            [Eindhoven, NL]
Physics: Plasma simulations <k.garloff@phys.tue.nl>   [TU Eindhoven, NL]
  (See mail header or public key servers for RSA and DSA public keys.)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
