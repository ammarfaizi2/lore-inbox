Return-Path: <linux-kernel-owner+w=401wt.eu-S1750917AbXARAMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbXARAMi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 19:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbXARAMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 19:12:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39012 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbXARAMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 19:12:38 -0500
Date: Thu, 18 Jan 2007 00:12:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] Kwatch: kernel watchpoints using CPU debug registers
Message-ID: <20070118001229.GA17257@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>,
	Prasanna S Panchamukhi <prasanna@in.ibm.com>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	Roland McGrath <roland@redhat.com>
References: <20070117094454.GB19093@elte.hu> <Pine.LNX.4.44L0.0701171114040.2381-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0701171114040.2381-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 11:17:37AM -0500, Alan Stern wrote:
> I'll be happy to move this over to the utrace setting, once it is merged.  
> Do you think it would be better to include the current version of kwatch 
> now or to wait for utrace?
> 
> Roland, is there a schedule for when you plan to get utrace into -mm?

Even if it goes into mainline soon we'll need a lot of time for all
architectures to catch up, so I think kwatch should definitely comes first.
