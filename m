Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWCFSPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWCFSPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWCFSPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:15:18 -0500
Received: from smtp-4.llnl.gov ([128.115.41.84]:53921 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S1751123AbWCFSPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:15:16 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Mon, 6 Mar 2006 10:14:22 -0800
User-Agent: KMail/1.5.3
Cc: torvalds@osdl.org, alan@redhat.com, gregkh@kroah.com
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <1141553885.16388.0.camel@laptopd505.fenrus.org> <1141554625.16388.2.camel@laptopd505.fenrus.org>
In-Reply-To: <1141554625.16388.2.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603061014.22312.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 March 2006 02:30, Arjan van de Ven wrote:
> On Sun, 2006-03-05 at 11:18 +0100, Arjan van de Ven wrote:
> > > +/* Main MC kobject release() function */
> > > +static void edac_memctrl_master_release(struct kobject *kobj)
> > > +{
> > > +	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
> > > +}
> > > +
> >
> > ehhh how on earth can this be right?
>
> oh and this stuff also violates the "one value per file" rule; can we
> fix that urgently before it becomes part of the ABI in 2.6.16??

Ok, I'll admit to being a bit clueless about this.  I'm not familiar
with the "one value per file" rule; can someone please explain?

On Sunday 05 March 2006 07:55, Greg KH wrote:
> Ugh.  Good catch, it isn't right.  Gotta love it when people try to
> ignore the helpful messages the kernel gives you when you use an API
> wrong :(

Hmm... I don't recall seeing any messages from the kernel.  What
are you seeing?
