Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbULDAgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbULDAgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 19:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbULDAgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 19:36:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:55986 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262516AbULDAgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 19:36:22 -0500
Date: Fri, 3 Dec 2004 16:40:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
Cc: gh@us.ibm.com, linux-kernel@vger.kernel.org, riel@redhat.com,
       mason@suse.com, ckrm-tech@lists.sourceforge.net, llp@CS.Princeton.EDU,
       acb@CS.Princeton.EDU, mlhuang@CS.Princeton.EDU, smuir@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [PATCH] CKRM: 0/10 Class Based Kernel Resource
 Management
Message-Id: <20041203164034.2191957c.akpm@osdl.org>
In-Reply-To: <NIBBJLJFDHPDIBEEKKLPMEBMCOAA.mef@cs.princeton.edu>
References: <E1CYu5M-00015C-00@w-gerrit.beaverton.ibm.com>
	<NIBBJLJFDHPDIBEEKKLPMEBMCOAA.mef@cs.princeton.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marc E. Fiuczynski" <mef@CS.Princeton.EDU> wrote:
>
> I integrated CKRM with the kernel used by PlanetLab (www.planet-lab.org),
> and I believe we (PlanetLab) are the first to use CKRM in a production
> setting.
> ...
> Hope this helps.

It does, thanks.

A concern which I have about the CKRM implementation is that the patches
which have been sent out appear to be simply the "core" of CKRM, plus
minimally-intrusive hooks.  I have the impression that this core will not
be terribly useful to real-world users and that follow-on patches will be
required to add more functionality and to wire up more instrumentation and
control points.

I would not like to be in a situation where we merge the "core" patch, but
the as-yet-unseen follow-on patches which make CKRM useful and complete end
up creating a big unmaintainable mess.  We end up not wanting to go
forwards and being unable to go backwards.

IOW: I think we need to see a reasonably-close-to-final implementation of
CKRM before we can take it much further.
