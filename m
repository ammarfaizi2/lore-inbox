Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVDHKf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVDHKf5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 06:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVDHKf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 06:35:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6551 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262717AbVDHKds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 06:33:48 -0400
Date: Fri, 8 Apr 2005 12:33:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mjg59@scrf.ucam.org, hare@suse.de
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050408103327.GD1392@elf.ucw.cz>
References: <20050405000524.592fc125.akpm@osdl.org> <20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net> <20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net> <20050405175600.644e2453.akpm@osdl.org> <20050406125958.GA8150@ip68-4-98-123.oc.oc.cox.net> <20050406142749.6065b836.akpm@osdl.org> <20050407030614.GA7583@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407030614.GA7583@ip68-4-98-123.oc.oc.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ok, I've narrowed the problem down to one patch. In 2.6.11-mm3, the
> > > problem goes away if I remove this patch:
> > > swsusp-enable-resume-from-initrd.patch
> > 
> > That really helps, thanks.
> 
> You're welcome.
> 
> > The patch looks fairly innocent.  I'll give up on this and cc the
> > developers.
> 
> Yeah, it *seemed* innocent enough -- that's why I had to do a binary
> search on the 2.6.11-mm3 "series" file in order to find it as the
> culprit...

Do you have XFS compiled in, by chance?

You are not actually resuming from initrd, right?
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
