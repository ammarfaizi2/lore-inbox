Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTGFRyk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 13:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTGFRyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 13:54:40 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:47331 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263103AbTGFRyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 13:54:39 -0400
Date: Sun, 6 Jul 2003 20:08:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Philippe Elie <phil.el@wanadoo.fr>, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>
Subject: Re: SPAM[RBL] Re: C99 types VS Linus types
Message-ID: <20030706200851.A22328@ucw.cz>
References: <200307060703.58533.bernie@develer.com> <3F0814B1.1000401@wanadoo.fr> <200307061937.26519.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200307061937.26519.bernie@develer.com>; from bernie@develer.com on Sun, Jul 06, 2003 at 07:37:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 07:37:26PM +0200, Bernardo Innocenti wrote:

> On Sunday 06 July 2003 14:23, Philippe Elie wrote:
> 
>  > alpha user space .h define uint64_t as unsigned long,
>  > include/asm-alpha/types.h defines it as unsigned long long.
> 
>  Why is that? Isn't uint64_t supposed to be _always_ a 64bit
> unsigned integer? Either the kernel or the user space might
> be doing the wrong thing...
> 
>  I've Cc'd the Alpha mantainer to make him aware of this
> problem.

I suppose both an 'unsigned long' and 'unsigned long long' are 64-bit
entities on the Alpha (which is a 64-bit architecture).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
