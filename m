Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVAQK0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVAQK0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 05:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVAQK0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 05:26:48 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:48533
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262758AbVAQK0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 05:26:46 -0500
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Karim Yaghmour <karim@opersys.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
In-Reply-To: <41EB1AEC.3000106@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	 <1105742791.13265.3.camel@tglx.tec.linutronix.de>
	 <41E8543A.8050304@am.sony.com>
	 <1105794499.13265.247.camel@tglx.tec.linutronix.de>
	 <41E9CCEF.50401@opersys.com> <Pine.LNX.4.61.0501160352130.6118@scrub.home>
	 <41E9EC5A.7070502@opersys.com>
	 <1105919017.13265.275.camel@tglx.tec.linutronix.de>
	 <41EB1AEC.3000106@opersys.com>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 11:26:43 +0100
Message-Id: <1105957604.13265.388.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 20:54 -0500, Karim Yaghmour wrote:

> If you really want to define layers, then there are actually four
> layers:
> 1- hooking mechanism
> 2- event definition / registration
> 3- event management infrastructure
> 4- transport mechanism
> 
> LTT currently does 1, 2 & 3. Clearly, as in the mail I refered to
> earlier, there is code in the kernel that already does 1, 2, 3,
> and 4 in very hardwired/ad-hoc fashion and there isn't anyone asking
> for them to remove it. We're offering 4 separately and are putting
> LTT on top of it. If you want to get 1 & 2 separately, have a look
> at kernel hooks and genevent:

I know that there is enough code which does x,y,z hardcoded/hardwired
already. 

Thats the point. Adding another hardwired implementation does not give
us a possibility to solve the hardwired problem of the already available
stuff.

tglx


