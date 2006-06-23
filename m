Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932754AbWFWBiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbWFWBiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbWFWBiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:38:04 -0400
Received: from ihug-mail.icp-qv1-irony6.iinet.net.au ([203.59.1.224]:30132
	"EHLO mail-ihug.icp-qv1-irony6.iinet.net.au") by vger.kernel.org
	with ESMTP id S932754AbWFWBiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:38:00 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,167,1149436800"; 
   d="scan'208"; a="348977052:sNHT17819099904"
Subject: Re: AGPGART: unable to get memory for graphics translation table.
From: Ian Kent <raven@themaw.net>
To: Avi Kivity <avi@argo.co.il>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <449ADD47.6000809@argo.co.il>
References: <1150997663.4372.8.camel@raven.themaw.net>
	 <449ADD47.6000809@argo.co.il>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 09:37:10 +0800
Message-Id: <1151026630.2623.1.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 21:11 +0300, Avi Kivity wrote:
> Ian Kent wrote:
> >
> > On Thu, 2006-06-22 at 17:00 +0300, Avi Kivity wrote:
> > > Ian Kent <raven <at> themaw.net> writes:
> > >
> > >  >
> > >  > On Sat, 17 Jun 2006, Dave Jones wrote:
> > >  >
> > >  > > On Sat, Jun 17, 2006 at 01:24:58PM +0800, Ian Kent wrote:
> > >  > >
> > >  > >  > Linux raven.themaw.net 2.6.16-1.2289_FC6xen #1 SMP Thu Jun 15
> > > 14:48:53 EDT
> > >  > >                                            ^^^
> > >  > >
> > >  > > I'll bet xen is to blame.  Can you try it on a plain kernel.org 
> > kernel?
> > >  >
> > >  > I tell a lie.
> > >  >
> > >  > Standard kernel now works.
> > >  > All I noticed between the dmesg files was that the init of the
> > > agpgart is
> > >  > somewhat later with the xen kernel.
> > >
> > > I'm getting this too. Were you able to resolve this somehow?
> > >
> >
> > Not yet.
> >
> I've chased it a bit, it's indeed a bug in xen-linux. May have a fix soon.

That would be great.

Ian

