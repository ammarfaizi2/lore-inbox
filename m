Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVACQYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVACQYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 11:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVACQYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 11:24:53 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29737
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261488AbVACQYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 11:24:52 -0500
Date: Mon, 3 Jan 2005 17:25:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, robert_hentosh@dell.com
Subject: Re: [PATCH][2/2] do not OOM kill if we skip writing many pages
Message-ID: <20050103162500.GX5164@dualathlon.random>
References: <Pine.LNX.4.61.0412201013420.13935@chimarrao.boston.redhat.com> <20050102172929.GL5164@dualathlon.random> <Pine.LNX.4.61.0501022319180.10640@chimarrao.boston.redhat.com> <20050103122241.GE29158@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103122241.GE29158@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 10:22:41AM -0200, Marcelo Tosatti wrote:
> What are the details of the OOM kills (output, workload, configuration, etc)? 
> 
> Are these running 2.6.10-mm? 

And did they apply Con's patch? (i.e. my 3/4 I posted few days ago)
