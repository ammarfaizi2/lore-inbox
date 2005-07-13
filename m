Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVGMU25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVGMU25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVGMU1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:27:05 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:17105 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262758AbVGMUYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:24:24 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: dtor_core@ameritech.net
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org,
       akpm@osdl.org, cw@f00f.org, christoph@lameter.com
In-Reply-To: <d120d50005071312322b5d4bff@mail.gmail.com>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <200507122239.03559.kernel@kolivas.org>
	 <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com>
	 <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com>
	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	 <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 16:24:18 -0400
Message-Id: <1121286258.4435.98.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 14:32 -0500, Dmitry Torokhov wrote:
> Hi,
> 
> On 7/13/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Wed, 2005-07-13 at 12:10 -0700, Linus Torvalds wrote:
> > > So we should aim for a HZ value that makes it easy to convert to and from
> > > the standard user-space interface formats. 100Hz, 250Hz and 1000Hz are all
> > > good values for that reason. 864 is not.
> > 
> > How about 500?  This might be good enough to solve the MIDI problem.
> >
> 
> I would expect number of laptop users significatly outnumber ones
> driving MIDI so as a default entry 250 makes more sense IMHO.
>  

Alan tested it and said that 250HZ does not save much power anyway.

Lee

