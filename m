Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWBCK6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWBCK6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWBCK6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:58:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48021 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030183AbWBCK6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:58:24 -0500
Date: Fri, 3 Feb 2006 11:58:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203105801.GE2830@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <20060202115907.GH1884@elf.ucw.cz> <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <1138916079.15691.130.camel@mindpipe> <20060202142323.088a585c.akpm@osdl.org> <1138919381.15691.162.camel@mindpipe> <20060203014846.GA61221@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060203014846.GA61221@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 03-02-06 02:48:46, Olivier Galibert wrote:
> On Thu, Feb 02, 2006 at 05:29:40PM -0500, Lee Revell wrote:
> > Follow up - do we have a rough idea how bad the suspend problem is, like
> > approximately what % of laptops don't DTRT and just suspend when you
> > close the lid?
> 
> None of the Dells we use at work (various models) handle suspend (both
> ram and disk) reliably.  Got everything from not resuming when pushing
> the button (PWRF not giving an ACPI event while PWRC does), screen not
> coming back (as usual), system not coming back the second time (go
> figure) or resume eating up / from time to time.  At that point people
> there are buying Macs.

Please debug suspend2disk first, and talk about them separately. They
are really different. If you have problem with suspend2disk, it should
be easy to solve it (or at least point you at problematic module). I
would not want to promise that for suspend2ram (we can usually fix
that, too, but). Please keep them separate.

								Pavel
-- 
Thanks, Sharp!
