Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUJOB3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUJOB3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUJOB3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:29:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28070 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267935AbUJOB3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:29:33 -0400
Date: Thu, 14 Oct 2004 18:26:44 -0700
From: Paul Jackson <pj@sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: ebiederm@xmission.com, mbligh@aracnet.com, Simon.Derr@bull.net,
       colpatch@us.ibm.com, pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041014182644.0a22ab53.pj@sgi.com>
In-Reply-To: <416EFFF8.2030408@watson.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
	<Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	<58780000.1097004886@flay>
	<20041005172808.64d3cc2b.pj@sgi.com>
	<1193270000.1097025361@[10.10.2.4]>
	<20041005190852.7b1fd5b5.pj@sgi.com>
	<1097103580.4907.84.camel@arrakis>
	<20041007015107.53d191d4.pj@sgi.com>
	<Pine.LNX.4.61.0410071439070.19964@openx3.frec.bull.fr>
	<1250810000.1097160595@[10.10.2.4]>
	<20041007105425.02e26dd8.pj@sgi.com>
	<1344740000.1097172805@[10.10.2.4]>
	<m1ekk1egdx.fsf@ebiederm.dsl.xmission.com>
	<20041014123956.518074f9.pj@sgi.com>
	<416EFFF8.2030408@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Huertus wrote:
> Paul, there are also other means for gang scheduling then having
> to architect a tightly synchronized global clock into the communication 
> device.

We agree.  

My reply to the post of Eric W. Biederman at the start of this
sub-thread began:

> In the simplest form, we obtain the equivalent of gang scheduling for
> the several threads of a tightly coupled job by arranging to have only
> one runnable thread per cpu, each such thread pinned on one cpu, and all
> threads in a given job simultaneously runnable.
> 
> For compute bound jobs, this is often sufficient. 

You reply adds substantial detail and excellent references.

Thank-you.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
