Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWIPQE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWIPQE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 12:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWIPQE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 12:04:27 -0400
Received: from 1wt.eu ([62.212.114.60]:46866 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S964812AbWIPQE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 12:04:27 -0400
Date: Sat, 16 Sep 2006 17:51:41 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Tom Mortensen <tmmlkml@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.x libata resync
Message-ID: <20060916155141.GA18409@1wt.eu>
References: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com> <20060916053713.GJ541@1wt.eu> <450B9940.5030609@gmail.com> <20060916063808.GK541@1wt.eu> <450C1CF2.4080308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450C1CF2.4080308@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 11:49:06AM -0400, Jeff Garzik wrote:
> Willy Tarreau wrote:
> >There are a bunch of small patches in the early 2.6 version which look
> >like bugfixes, but with non-descriptive comments, so I'm not sure what
> >they fix. Several of them would apply to 2.4, but I don't want to touch
> >this area as long as nobody complains about problems.
> 
> Oh there are tons of SATA bug fixes that 2.4.x is missing.  One of the 
> biggest is the completely crappy exception handling.  If a SATA device 
> is unplugged or spazzes out, the system may or may not recover.

Already encountered on sata_nv in a sun x2100 :-)

Jeff, I did not want to blindly merge patches from 2.6 to 2.4, but if
you point me to a few ones you consider important, I'm willing to merge
them.

Regards,
Willy

