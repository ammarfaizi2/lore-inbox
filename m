Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUJJAIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUJJAIi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 20:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267765AbUJJAIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 20:08:38 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:51676 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267661AbUJJAIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 20:08:25 -0400
Date: Sat, 9 Oct 2004 17:05:12 -0700
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: frankeh@watson.ibm.com, ricklind@us.ibm.com, mbligh@aracnet.com,
       Simon.Derr@bull.net, pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] Re: [PATCH] cpusets - big numa cpu and memory
 placement
Message-Id: <20041009170512.5edf0b7e.pj@sgi.com>
In-Reply-To: <1097283613.6470.146.camel@arrakis>
References: <20041007015107.53d191d4.pj@sgi.com>
	<200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	<20041007072842.2bafc320.pj@sgi.com>
	<4165A31E.4070905@watson.ibm.com>
	<20041008061426.6a84748c.pj@sgi.com>
	<4166B569.60408@watson.ibm.com>
	<20041008112319.63b694de.pj@sgi.com>
	<1097283613.6470.146.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew writes:
> > CKRM aspires to be both a general purpose resource management framework
> > and the embodiment of fair share scheduling.
> 
> I think your missing something here.  CKRM, as I understand it, aspires
> to be a general purpose resource management framework.  To that point I
> will accede.  But the second part, about CKRM being the embodiment of
> fair share scheduling, is secondary.

Ok - you may well be right that CKRM does not aspire to be the embodiment
of fair share scheduling.  But doesn't it embody a fair share sheduler
(and no other such policy) as a matter of current implementation fact?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
