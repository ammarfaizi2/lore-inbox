Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUJEW03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUJEW03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUJEW03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:26:29 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:21684 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266186AbUJEW01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:26:27 -0400
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
	memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Simon.Derr@bull.net,
       Andi Kleen <ak@suse.de>, sivanich@sgi.com
In-Reply-To: <20041005021736.40f51b33.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	 <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]>
	 <200408061730.06175.efocht@hpce.nec.com>
	 <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>
	 <20041001164118.45b75e17.akpm@osdl.org>
	 <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com>
	 <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au>
	 <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com>
	 <834330000.1096847619@[10.10.2.4]> <835810000.1096848156@[10.10.2.4]>
	 <20041003175309.6b02b5c6.pj@sgi.com> <838090000.1096862199@[10.10.2.4]>
	 <20041003212452.1a15a49a.pj@sgi.com> <843670000.1096902220@[10.10.2.4]>
	 <20041004085327.727191bf.pj@sgi.com> <118120000.1096913871@flay>
	 <20041004132551.551c9fd3.pj@sgi.com> <13000000.1096928155@flay>
	 <20041005021736.40f51b33.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097015088.4065.53.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 05 Oct 2004 15:24:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 02:17, Paul Jackson wrote:
> The /dev/cpuset pseudo file system api was chosen because it was
> convenient for small scale work, learning and experimentation, because
> it was a natural for the hierarchical name space with permissions that I
> required, and because it was convenient to leverage existing vfs
> structure in the kernel.

I really like the /dev/cpuset FS.  I would like to leverage most of that
code to be the user level interface to creating, linking & destroying
sched_domains at some point.  This, of course, is assuming that the
dynamic sched_domains concept meets with something less than catcalls
and jeers... ;)

-Matt

