Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbWFVSL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWFVSL3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWFVSL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:11:29 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:8454 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932279AbWFVSL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:11:28 -0400
Message-ID: <449ADD47.6000809@argo.co.il>
Date: Thu, 22 Jun 2006 21:11:19 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Ian Kent <raven@themaw.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: AGPGART: unable to get memory for graphics translation table.
References: <1150997663.4372.8.camel@raven.themaw.net>
In-Reply-To: <1150997663.4372.8.camel@raven.themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2006 18:11:25.0985 (UTC) FILETIME=[46A69110:01C69627]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent wrote:
>
> On Thu, 2006-06-22 at 17:00 +0300, Avi Kivity wrote:
> > Ian Kent <raven <at> themaw.net> writes:
> >
> >  >
> >  > On Sat, 17 Jun 2006, Dave Jones wrote:
> >  >
> >  > > On Sat, Jun 17, 2006 at 01:24:58PM +0800, Ian Kent wrote:
> >  > >
> >  > >  > Linux raven.themaw.net 2.6.16-1.2289_FC6xen #1 SMP Thu Jun 15
> > 14:48:53 EDT
> >  > >                                            ^^^
> >  > >
> >  > > I'll bet xen is to blame.  Can you try it on a plain kernel.org 
> kernel?
> >  >
> >  > I tell a lie.
> >  >
> >  > Standard kernel now works.
> >  > All I noticed between the dmesg files was that the init of the
> > agpgart is
> >  > somewhat later with the xen kernel.
> >
> > I'm getting this too. Were you able to resolve this somehow?
> >
>
> Not yet.
>
I've chased it a bit, it's indeed a bug in xen-linux. May have a fix soon.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

