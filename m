Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271021AbTHGVwD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271034AbTHGVwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:52:03 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:22434 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S271021AbTHGVvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:51:32 -0400
Date: Thu, 7 Aug 2003 23:51:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client notification mecanism & PM
Message-ID: <20030807215116.GD413@elf.ucw.cz>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org> <1060249101.1077.67.camel@gaston> <20030807100309.GB166@elf.ucw.cz> <1060263168.593.77.camel@gaston> <1060292180.3507.27.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060292180.3507.27.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Would this play well with the suspend process itself displaying output?
> (Eg progress, errors...).

Yes.
								Pavel


...
> > > I believe solution to this is simple: always switch to kernel-owned
> > > console during suspend. (swsusp does it, there's patch for S3 to do
> > > the same). That way, Xfree (or qtopia or whoever) should clean up
> > > after themselves and leave the console to the kernel. (See
> > > kernel/power/console.c)
> > 
> > I admit I quite like this solution. It would also help displaying
> > something sane (blank, pattern, whatever) on screen during driver
> > teardown instead of the junk left by X...
> > 
> > I'll look into including that switch into my pmac code as well
> > and see if it works properly in all cases (I think so). Also,
> > recent DRI CVS finally has working suspend/resume (works on
> > console switch too).
> > 
> > Ben.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
