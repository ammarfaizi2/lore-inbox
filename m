Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbVIEVcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbVIEVcA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbVIEVcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:32:00 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:1970 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932600AbVIEVb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:31:59 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [GIT PATCHES] kbuild updates
Date: Mon, 5 Sep 2005 22:32:04 +0100
User-Agent: KMail/1.8.90
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <20050905174150.GA17923@mars.ravnborg.org> <200509052035.14156.s0348365@sms.ed.ac.uk> <20050905201345.GA26106@mars.ravnborg.org>
In-Reply-To: <20050905201345.GA26106@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509052232.04135.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 September 2005 21:13, Sam Ravnborg wrote:
> On Mon, Sep 05, 2005 at 08:35:14PM +0100, Alistair John Strachan wrote:
> > On Monday 05 September 2005 18:41, Sam Ravnborg wrote:
> > > Hi Linus.
> > >
> > > kbuild updates as accumulated over the last few months.
> > > All patches has been in -mm in one or several versions.
> > >
> > > Most noteworthy:
> > > 1) -Wundef added to CFLAGS. This is the cause of several new warnings,
> > >    which for the most part has been fixed for now.
> > > 2) "PREEMPT" in UTS_VERSION. So we complain when dealing
> > >    with modules compiled for a wrong kernel
> >
> > How is this different from the preempt module vermagic?
> >
> > ~$ modinfo agpgart | grep vermagic
> > vermagic:       2.6.13 preempt gcc-4.0
>
> My bad. Adding PREEMT to UTS_VERSION makes it visible in uname -a.
>

I see. I can understand adding an extraversion for SMP and experimental 
patches (like Ingo's RT work), but why is it useful to differentiate (by 
name) between preempt and non-preempt kernels? Do distributors wish to 
package both in parallel?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
