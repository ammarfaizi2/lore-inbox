Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266157AbUGTTYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUGTTYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUGTTYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:24:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17364 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266157AbUGTTUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:20:21 -0400
Date: Tue, 20 Jul 2004 15:17:00 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
Subject: Re: [PATCH][2.4 Backport] x445 usb legacy fix
Message-ID: <20040720181700.GA2576@dmt.cyclades>
References: <1090289222.1388.461.camel@cog.beaverton.ibm.com> <20040719200608.280d17a1@lembas.zaitcev.lan> <1090344174.1388.471.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090344174.1388.471.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 10:22:55AM -0700, john stultz wrote:
> On Mon, 2004-07-19 at 20:06, Pete Zaitcev wrote:
> > On Mon, 19 Jul 2004 19:07:03 -0700
> > john stultz <johnstul@us.ibm.com> wrote:
> > 
> > The patch looks a little dirty in small places, e.g. the double
> > semicolon, the HZ/100 instead of HZ/10, space, two variables
> > named "base" in two blocks. I do not believe Vojtech wrote it.
> > He must have gotten it from someone else.
> 
> The whitespace and double semicolon have been removed already. I'm not
> sure I follow the HZ/100 bit (as my understanding is 1/100'th of a
> second is the desired wait time). If you could clarify the error you
> see, I'll fix it and resend the patch.
> 
> > But in any case, it's not something I can decide. Marcelo has that
> > power for stock kernels, and for Red Hat kernels there's a process
> > which starts with Bugzilla.
> 
> I was under the impression you were the 2.4 USB maintainer. Am I
> misdirecting this patch? 

No, you are sending to the right person, Pete is the v2.4 USB maintainer.

The most sensible thing to do seems to wait for this to get into v2.6 
mainline, let it stabilize, and then include it in v2.4 (Greg suggested
this approach and I completly agree with him).

