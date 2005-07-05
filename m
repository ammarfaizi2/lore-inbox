Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVGEWDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVGEWDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVGEWBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:01:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:5826 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261984AbVGEV5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:57:53 -0400
Date: Tue, 5 Jul 2005 14:57:40 -0700
From: Greg KH <greg@kroah.com>
To: Zan Lynx <zlynx@acm.org>
Cc: Michal Jaegermann <michal@harddata.com>, linux-kernel@vger.kernel.org
Subject: Re: A "new driver model" and EXPORT_SYMBOL_GPL question
Message-ID: <20050705215739.GA2635@kroah.com>
References: <20050703171202.A7210@mail.harddata.com> <20050704054441.GA19936@kroah.com> <1120600243.27600.75.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120600243.27600.75.camel@localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 03:50:43PM -0600, Zan Lynx wrote:
> Sourced from here:
> http://hulllug.principalhosting.net/archive/index.php/t-52440.html

No, that is not the same topic or thread.

> That was the way it was as of 2.6.10-mm1 and it stayed that way through
> 2.6.12.  When did that decision change?  If it was there in the
> archives, I missed it in the search.

The code was totally rewritten from what was in 2.6.10-mm1, it was not
just a simple "license change".  All in-kernel users were converted, and
the known closed-source users of this code were also contacted and they
have already changed their code (nvidia being one of these users.)

If you know of any closed source code, using those functions, please put
them in contact with me.

> If this was a Greg-only decision, perhaps a patch reversing the change
> addressed to Linus would get a solid yes/no decision from the top.

What problem is this change causing you?  Do you have code that calls
these old, now gone, functions?

thanks,

greg k-h
