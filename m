Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTESQEV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTESQEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:04:21 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:34323 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261309AbTESQEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:04:20 -0400
Date: Mon, 19 May 2003 17:17:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux.nics@intel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add boot command line parsing for the e100 driver
Message-ID: <20030519171714.A22487@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Corey Minyard <cminyard@mvista.com>, linux.nics@intel.com,
	LKML <linux-kernel@vger.kernel.org>
References: <3EC901BB.8040100@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EC901BB.8040100@mvista.com>; from cminyard@mvista.com on Mon, May 19, 2003 at 11:09:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 11:09:31AM -0500, Corey Minyard wrote:
> Annoyed by the fact that I could set configuration parameters for a
> compiled-in e100 driver, I've added boot-line parameter parsing.  The
> patch is attached.  It would be very helpful if this could be applied. 
> This is relative to 2.5.68, but should be pretty portable.

Don't do this. 2.5 has the module_parame stuff that works for both
static and modular drivers.  Just convert e100 to it.

