Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWDJKnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWDJKnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWDJKnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:43:02 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:17683 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751128AbWDJKnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:43:01 -0400
Date: Mon, 10 Apr 2006 12:42:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/19] kconfig: move .kernelrelease
Message-ID: <20060410104250.GA24160@mars.ravnborg.org>
References: <Pine.LNX.4.64.0604091728560.23148@scrub.home> <20060410015727.69b5c1f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410015727.69b5c1f6.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 01:57:27AM -0700, Andrew Morton wrote:
> Roman Zippel <zippel@linux-m68k.org> wrote:
> >
> > This moves the .kernelrelease file into include/config directory.
> >  Remove its generation from the config step, if the config step doesn't
> >  leave a proper .config behind, it triggers a call to silentoldconfig.
> >  Instead its generation can be done via proper dependencies.
> 
> Well that was a pita.  I was using that file in my kernel installation
> script.
> 
> Your changelog says what the patch does, but gives no indication of why it
> did it.
> 
> What do we get back for the breakage which this will cause?
> 
> Now I'm going to have to look for both .kernelrelease and
> include/config/kernel.release and work out which one has the more recent
> mtime.  grr.
That you have for not using 'make kernelrelease' - he ;-)
Did you not know, or did make kernelrelease not do what you expected?

	Sam
