Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269313AbUJKWnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269313AbUJKWnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269315AbUJKWnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:43:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14251 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269313AbUJKWng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:43:36 -0400
Date: Mon, 11 Oct 2004 15:39:57 -0700
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
Message-Id: <20041011153957.1111dc06.pj@sgi.com>
In-Reply-To: <1097533108.4038.64.camel@arrakis>
References: <20041007015107.53d191d4.pj@sgi.com>
	<200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	<20041007072842.2bafc320.pj@sgi.com>
	<4165A31E.4070905@watson.ibm.com>
	<20041008061426.6a84748c.pj@sgi.com>
	<4166B569.60408@watson.ibm.com>
	<20041008112319.63b694de.pj@sgi.com>
	<1097283613.6470.146.camel@arrakis>
	<20041009170512.5edf0b7e.pj@sgi.com>
	<1097533108.4038.64.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes.  That is true, but it is by no means meant to be the end-all,
> be-all of CKRM.  

All well and good.  Except that it has taken me an inordinate amount of
effort to grok what CKRM is, and this mingling of a framework for
resource management with one particular instance of such, a fair share
scheduler, has contributed to my confusions.  My teen age son can no
doubt offer additional explanations for my confusions.

And indeed, while a new kernel framework should come with at least one
good example of something worth so framing, still it's better to keep
the two clearly distinguished.  If these two are well distinguished now,
then I am unaware of that.

Perhaps this effort to add a placement manager to the existing fair
share manager in CKRM's repetoire will result in a clearer separation of
the CKRM framework from that which it frames.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
