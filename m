Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVACP0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVACP0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 10:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVACP0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 10:26:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26787 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261473AbVACP0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 10:26:35 -0500
Date: Mon, 3 Jan 2005 10:22:41 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, robert_hentosh@dell.com
Subject: Re: [PATCH][2/2] do not OOM kill if we skip writing many pages
Message-ID: <20050103122241.GE29158@logos.cnet>
References: <Pine.LNX.4.61.0412201013420.13935@chimarrao.boston.redhat.com> <20050102172929.GL5164@dualathlon.random> <Pine.LNX.4.61.0501022319180.10640@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501022319180.10640@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 11:20:28PM -0500, Rik van Riel wrote:
> On Sun, 2 Jan 2005, Andrea Arcangeli wrote:
> 
> >I don't like this one, it's much less obvious than 1/2. After your
> >obviously right 1/2 we're already guaranteed at least a percentage of
> >the ram will not be dirty. Is the below really needed even after 1/2 +
> >Andrew's fix? Are you sure this isn't a workaround for the lack of
> >Andrew's fix.
> 
> Agreed, Andrew's fix should in theory be enough and only my
> 1/2 should be needed.
> 
> However, in practice people are still generating OOM kills
> even with both Andrew's fix and my own patch applied, so I
> suspect there's another hole left open somewhere...

Hi Rik,

What are the details of the OOM kills (output, workload, configuration, etc)? 

Are these running 2.6.10-mm? 


