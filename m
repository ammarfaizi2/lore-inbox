Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161403AbWG2Cgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161403AbWG2Cgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161404AbWG2Cgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:36:38 -0400
Received: from colin.muc.de ([193.149.48.1]:2057 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1161403AbWG2Cgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:36:37 -0400
Date: 29 Jul 2006 04:36:34 +0200
Date: Sat, 29 Jul 2006 04:36:34 +0200
From: Andi Kleen <ak@muc.de>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
Message-ID: <20060729023634.GC35643@muc.de>
References: <20060727015639.9c89db57.akpm@osdl.org> <1154112276.3530.3.camel@amdx2.microgate.com> <20060728144854.44c4f557.akpm@osdl.org> <20060728233851.GA35643@muc.de> <1154132126.3349.8.camel@localhost.localdomain> <1154135792.2557.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154135792.2557.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 08:16:32PM -0500, Paul Fulghum wrote:
> On Fri, 2006-07-28 at 19:15 -0500, Paul Fulghum wrote:
> > I'm doing a build on my home machine now to see if it
> > happens there also.
> 
> Well, the timer int 0 problem does not happen on my home machine.

Yes, it only happens on a few machines.

> 2.6.18-rc2 works fine with same config.
> 
> In this case the error is:
> 
> No per-cpu room for modules

That's also a known problem, but a different one.

-Andi
