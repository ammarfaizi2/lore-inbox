Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWCZPjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWCZPjF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 10:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWCZPjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 10:39:05 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:50311 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1751320AbWCZPjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 10:39:04 -0500
Date: Sun, 26 Mar 2006 17:38:59 +0200
From: Martin Mares <mj@ucw.cz>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header	infrastructure
Message-ID: <mj+md-20060326.153649.8590.albireo@ucw.cz>
References: <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <1143376351.3064.9.camel@laptopd505.fenrus.org> <A6491D09-3BCF-4742-A367-DCE717898446@mac.com> <mj+md-20060326.125803.7105.albireo@ucw.cz> <50ACA1D0-C376-491A-A927-872B04964663@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50ACA1D0-C376-491A-A927-872B04964663@mac.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It _is_ fragile, but for a number of POSIX-defined structs that's  
> actually the only way to do it without duplicating the data structure  
> in entirety, unless the GCC people can implement a "typedef struct  
> foo struct bar;"

Actually, something like that can be achieved using anonymous structure
members:

struct xxx {
	struct yyy;
};

However, I'm not sure how old versions of GCC support this feature.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
And God said: E = 1/2mv^2 - Ze^2/r ...and there *WAS* light!
