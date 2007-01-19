Return-Path: <linux-kernel-owner+w=401wt.eu-S932662AbXASRM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbXASRM1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbXASRM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:12:27 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:62337 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662AbXASRM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:12:26 -0500
X-AuditID: d80ac21c-a3b0fbb00000330a-a9-45b0fbfabb0f 
Date: Fri, 19 Jan 2007 17:12:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Nadia Derbey <Nadia.Derbey@bull.net>, Franck Bui-Huu <fbuihuu@gmail.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: unable to mmap /dev/kmem
In-Reply-To: <1169225824.3055.507.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0701191704510.7577@blonde.wat.veritas.com>
References: <45AFA490.5000508@bull.net>  <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
  <45B08B17.3060807@bull.net>  <Pine.LNX.4.64.0701191539070.4009@blonde.wat.veritas.com>
 <1169225824.3055.507.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Jan 2007 17:12:13.0101 (UTC) FILETIME=[F620BDD0:01C73BEC]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Arjan van de Ven wrote:
> On Fri, 2007-01-19 at 16:33 +0000, Hugh Dickins wrote:
> > Though I do wonder whether
> > it was safe to change its behaviour at that stage: more evidence that
> > few have actually been using mmap of /dev/kmem. 
> 
> ... and maybe we should just kill /dev/kmem entirely... it seems mostly
> used by rootkits but very few other things, if any at all...

It was discourteous of me not to CC you: I thought you might say that ;)
Though so long as /dev/mem support remains, /dev/kmem might as well?
And be kept as a CONFIG_ option under DEBUG_KERNEL thereafter?

Hugh
