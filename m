Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266848AbTADM76>; Sat, 4 Jan 2003 07:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266859AbTADM76>; Sat, 4 Jan 2003 07:59:58 -0500
Received: from samael.donpac.ru ([195.161.172.239]:24071 "EHLO
	samael.donpac.ru") by vger.kernel.org with ESMTP id <S266848AbTADM75>;
	Sat, 4 Jan 2003 07:59:57 -0500
From: "Andrey Panin" <pazke@orbita1.ru>
Date: Sat, 4 Jan 2003 16:03:52 +0300
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] irq handling code consolidation, second try (v850 part)
Message-ID: <20030104130352.GK10477@pazke>
Mail-Followup-To: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
References: <87hecp83yq.fsf@tc-1-100.kawasaki.gol.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hecp83yq.fsf@tc-1-100.kawasaki.gol.ne.jp>
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 10:00:29PM +0900, Miles Bader wrote:
> Can't test it, but the v850 part looks great, ah, it's lovely to see all
> that code being deleted...
> 
> One comment:  `arch_check_irq' is a bad name, it doesn't make it at all
> clear what it does.
> 
> I might suggest inverting the sense, and using `irq_valid' -- the `arch_'
> prefix seems unnecessary (as with `irq_desc') since it's not a
> arch-specific version of a more general wrapper.

I used arch_ prefix to clearly mark arch specifig things, but
irq_valid() is probably a better name. Comments ?
 
-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net
