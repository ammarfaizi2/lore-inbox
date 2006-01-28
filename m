Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422828AbWA1EsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422828AbWA1EsG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 23:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422826AbWA1EsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 23:48:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932512AbWA1EsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 23:48:05 -0500
Date: Fri, 27 Jan 2006 23:44:27 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc Perkel <marc@perkel.com>
cc: Chase Venters <chase.venters@clientec.com>,
       Diego Calleja <diegocg@gmail.com>, Paul Jakma <paul@clubi.ie>,
       linux-os@analogic.com, mrmacman_g4@mac.com,
       jmerkey@wolfmountaingroup.com, pmclean@cs.ubishops.ca,
       shemminger@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - V3 adds new restrictions
In-Reply-To: <43D94D1D.8070300@perkel.com>
Message-ID: <Pine.LNX.4.64.0601272340230.2909@evo.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com> <20060120111103.2ee5b531@dxpl.pdx.osdl.net>
 <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>
 <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com>
 <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <Pine.LNX.4.64.0601261757320.3920@sheen.jakma.org>
 <20060126195323.d553a4b8.diegocg@gmail.com> <Pine.LNX.4.64.0601261255430.17225@turbotaz.ourhouse>
 <43D92175.6010804@perkel.com> <Pine.LNX.4.64.0601261344220.17514@turbotaz.ourhouse>
 <43D92B45.1030601@perkel.com> <Pine.LNX.4.64.0601261416090.17514@turbotaz.ourhouse>
 <43D94D1D.8070300@perkel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Jan 2006, Marc Perkel wrote:
>
> Trying to look at this from a legal point of view. GPLv3 might actually
> contradict GPLv2.

The GPLv2 is explicitly written so that _nothing_ else than a GPLv2 
license can be compatible with it.

At most you can dual-license and effectively allow extra rights that way, 
but the point is that the GPLv2 is always the limit for any restrictions 
(and it's written so that anybody can always take any but the GPLv2 
freedoms away - so if you dual-license, your licensees can always decide 
to _only_ honor the GPLv2, and ignore any other license).

That's why, in order to re-license anythingt from GPLv2 to anything else, 
the license grant itself must make it clear that the "anything else" was 
always permissible in the first place. Which is why the FSF had only two 
"outs": either people explicitly do the "..or any later version" thing, 
_or_ people don't mention the version of the GPL at all, in which case any 
version will do.

		Linus
