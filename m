Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269299AbUJKWUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269299AbUJKWUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269300AbUJKWUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:20:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:9959 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269299AbUJKWTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:19:36 -0400
Subject: Re: [Lse-tech] Re: [PATCH] cpusets - big numa cpu and memory
	placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: frankeh@watson.ibm.com, Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <20041009170512.5edf0b7e.pj@sgi.com>
References: <20041007015107.53d191d4.pj@sgi.com>
	 <200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	 <20041007072842.2bafc320.pj@sgi.com> <4165A31E.4070905@watson.ibm.com>
	 <20041008061426.6a84748c.pj@sgi.com> <4166B569.60408@watson.ibm.com>
	 <20041008112319.63b694de.pj@sgi.com> <1097283613.6470.146.camel@arrakis>
	 <20041009170512.5edf0b7e.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097533108.4038.64.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 11 Oct 2004 15:18:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 17:05, Paul Jackson wrote:
> Matthew writes:
> > > CKRM aspires to be both a general purpose resource management framework
> > > and the embodiment of fair share scheduling.
> > 
> > I think your missing something here.  CKRM, as I understand it, aspires
> > to be a general purpose resource management framework.  To that point I
> > will accede.  But the second part, about CKRM being the embodiment of
> > fair share scheduling, is secondary.
> 
> Ok - you may well be right that CKRM does not aspire to be the embodiment
> of fair share scheduling.  But doesn't it embody a fair share sheduler
> (and no other such policy) as a matter of current implementation fact?

Yes.  That is true, but it is by no means meant to be the end-all,
be-all of CKRM.  It is my understanding that the fair share scheduler is
a proof-of-concept and an example of how to write a 'controller' for
others, but not the full extent of CKRM's power.

-Matt

