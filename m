Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261838AbTCQSPm>; Mon, 17 Mar 2003 13:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbTCQSPm>; Mon, 17 Mar 2003 13:15:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:31497 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261838AbTCQSPl>;
	Mon, 17 Mar 2003 13:15:41 -0500
Date: Mon, 17 Mar 2003 19:26:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][KBUILD] Fix filechk_gen-asm-offsets
Message-ID: <20030317182635.GB4281@mars.ravnborg.org>
Mail-Followup-To: Marc Zyngier <mzyngier@freesurf.fr>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <wrpisuib4o8.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrpisuib4o8.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 12:42:15PM +0100, Marc Zyngier wrote:
> Sam,
> 
> It looks like kbuild was recently broken by the filechk changes.
> At least on Alpha, filechk_gen-asm-offsets is getting nothing but
> stdin... Not very useful ;-). All platforms but x86 look broken too.

Thanks - forgot to test my last version on ppc (which I use
for cross-compile testing atm.).

Kai already sent the fix to Linus a few hours ago, so it is solved
in Linus-BK.

	Sam
