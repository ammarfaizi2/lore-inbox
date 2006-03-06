Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWCFSVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWCFSVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWCFSVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:21:10 -0500
Received: from xenotime.net ([66.160.160.81]:8851 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750823AbWCFSVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:21:09 -0500
Date: Mon, 6 Mar 2006 10:22:32 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Dave Peterson <dsp@llnl.gov>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       alan@redhat.com, gregkh@kroah.com
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-Id: <20060306102232.613911f6.rdunlap@xenotime.net>
In-Reply-To: <200603061014.22312.dsp@llnl.gov>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	<1141553885.16388.0.camel@laptopd505.fenrus.org>
	<1141554625.16388.2.camel@laptopd505.fenrus.org>
	<200603061014.22312.dsp@llnl.gov>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2006 10:14:22 -0800 Dave Peterson wrote:

> On Sunday 05 March 2006 02:30, Arjan van de Ven wrote:
> > On Sun, 2006-03-05 at 11:18 +0100, Arjan van de Ven wrote:
> > > > +/* Main MC kobject release() function */
> > > > +static void edac_memctrl_master_release(struct kobject *kobj)
> > > > +{
> > > > +	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
> > > > +}
> > > > +
> > >
> > > ehhh how on earth can this be right?
> >
> > oh and this stuff also violates the "one value per file" rule; can we
> > fix that urgently before it becomes part of the ABI in 2.6.16??
> 
> Ok, I'll admit to being a bit clueless about this.  I'm not familiar
> with the "one value per file" rule; can someone please explain?

it's in Documentation/filesystems/sysfs.txt
Strongly preferred.

> On Sunday 05 March 2006 07:55, Greg KH wrote:
> > Ugh.  Good catch, it isn't right.  Gotta love it when people try to
> > ignore the helpful messages the kernel gives you when you use an API
> > wrong :(
> 
> Hmm... I don't recall seeing any messages from the kernel.  What
> are you seeing?



---
~Randy
