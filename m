Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVDJXBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVDJXBP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVDJXBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:01:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29884 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261628AbVDJXBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:01:11 -0400
Date: Mon, 11 Apr 2005 01:00:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, hare@suse.de
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050410230053.GD12794@elf.ucw.cz>
References: <20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net> <20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net> <20050405175600.644e2453.akpm@osdl.org> <20050406125958.GA8150@ip68-4-98-123.oc.oc.cox.net> <20050406142749.6065b836.akpm@osdl.org> <20050407030614.GA7583@ip68-4-98-123.oc.oc.cox.net> <20050408103327.GD1392@elf.ucw.cz> <20050410211808.GA12118@ip68-4-98-123.oc.oc.cox.net> <20050410212747.GB26316@elf.ucw.cz> <20050410225708.GB12118@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410225708.GB12118@ip68-4-98-123.oc.oc.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can you try without XFS?
> 
> No, XFS is my root filesystem. :( (Now that I think about it, would
> modularizing XFS and using an initrd be OK?)

Yes, loading xfs from initrd should help. [At least it did during
suse9.3 testing.]

> I'll see if I can reproduce this on one of my test boxes. I'll *try* to
> get to it later today, but it's possible that I won't be able to get to
> it until next Friday or Saturday.
> 
> > I do not why it interferes, but I've seen that before on suse
> > kernels...
> 
> Have you seen it without the resume-from-initrd patch too, or only with
> that patch?

Only with resume-from-initrd.
									Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
