Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUHBVQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUHBVQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUHBVQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:16:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:22005 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263713AbUHBVQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:16:27 -0400
Subject: Re: [PATCH] Create cpu_sibling_map for PPC64
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, LKML <linux-kernel@vger.kernel.org>,
       LSE Tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <20040731214512.36123c10.akpm@osdl.org>
References: <1091049554.19459.33.camel@arrakis>
	 <20040731214512.36123c10.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1091481370.4415.35.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 02 Aug 2004 14:16:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 21:45, Andrew Morton wrote:
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> >
> > In light of some proposed changes in the sched_domains code, I coded up
> >  this little ditty that simply creates and populates a cpu_sibling_map
> >  for PPC64 machines.
> 
> err, did you compile it?

Oh, you wanted the version that compiles!?!  ;)  Besides me being really
bad at counting dots, our lab was down for a bit and I didn't test or
compile that before I sent it.  I was sending it more as an RFC than a
patch destined for acceptance (yet).  I still don't have access to a
machine to test it on, but I hope to snag some time soon.  Glad to see
*someone* is reading my code, though, since it obviously isn't me! ;)

-Matt

