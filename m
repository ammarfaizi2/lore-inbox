Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422895AbWBILXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422895AbWBILXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 06:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422896AbWBILXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 06:23:46 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:57225 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1422895AbWBILXp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 06:23:45 -0500
Subject: Re: preempt-rt, NUMA and strange latency traces
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: john stultz <johnstul@us.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139483492.5706.12.camel@frecb000686>
References: <1139311689.19708.36.camel@frecb000686>
	 <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
	 <1139395534.21471.13.camel@frecb000686>
	 <1139417369.16302.1.camel@leatherman>
	 <1139483492.5706.12.camel@frecb000686>
Date: Thu, 09 Feb 2006 12:26:53 +0100
Message-Id: <1139484413.5706.22.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/02/2006 12:24:46,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/02/2006 12:24:46,
	Serialize complete at 09/02/2006 12:24:46
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 12:11 +0100, Sébastien Dugué wrote:
> On Wed, 2006-02-08 at 08:49 -0800, john stultz wrote:
> > On Wed, 2006-02-08 at 11:45 +0100, Sébastien Dugué wrote:
> > >   The more I think about it, the more I tend to believe it's hardware 
> > > related. It seems as if the CPU just hangs for ~27 ms before
> > > resuming processing.
> > 
> > That sounds like to the ~30ms RSA caused SMIs. Does this system have an
> > RSA1 or RSA2 card?
> > 

  OK just found burried deep into IBM website docs that the x440 comes
standard with a plain RSA (not RSA2).

  Sébastien.

