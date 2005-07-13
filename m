Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVGMUyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVGMUyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVGMUye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:54:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51163 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262844AbVGMUsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:48:22 -0400
Date: Wed, 13 Jul 2005 13:48:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>, "Brown, Len" <len.brown@intel.com>
Cc: dtor_core@ameritech.net, torvalds@osdl.org, vojtech@suse.cz,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, cw@f00f.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-Id: <20050713134857.354e697c.akpm@osdl.org>
In-Reply-To: <1121286258.4435.98.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	<200507122239.03559.kernel@kolivas.org>
	<200507122253.03212.kernel@kolivas.org>
	<42D3E852.5060704@mvista.com>
	<20050712162740.GA8938@ucw.cz>
	<42D540C2.9060201@tmr.com>
	<Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	<20050713184227.GB2072@ucw.cz>
	<Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	<1121282025.4435.70.camel@mindpipe>
	<d120d50005071312322b5d4bff@mail.gmail.com>
	<1121286258.4435.98.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Wed, 2005-07-13 at 14:32 -0500, Dmitry Torokhov wrote:
> > Hi,
> > 
> > On 7/13/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > > On Wed, 2005-07-13 at 12:10 -0700, Linus Torvalds wrote:
> > > > So we should aim for a HZ value that makes it easy to convert to and from
> > > > the standard user-space interface formats. 100Hz, 250Hz and 1000Hz are all
> > > > good values for that reason. 864 is not.
> > > 
> > > How about 500?  This might be good enough to solve the MIDI problem.
> > >
> > 
> > I would expect number of laptop users significatly outnumber ones
> > driving MIDI so as a default entry 250 makes more sense IMHO.
> >  
> 
> Alan tested it and said that 250HZ does not save much power anyway.
> 

Len Brown, a year ago: "The bottom line number to laptop users is battery
lifetime.  Just today somebody complained to me that Windows gets twice the
battery life that Linux does."

And "Maybe I can get Andy Grover over in the moble lab to get some time on
that fancy power measurement setup they have...

"My expectation is if we want to beat the competition, we'll want the
ability to go *under* 100Hz."

But then, power consumption of the display should preponderate, so it's not
clear.

Len, any updates on the relationship between HZ and power consumption?
