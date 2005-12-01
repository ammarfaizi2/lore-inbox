Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVLAQAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVLAQAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVLAQAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:00:54 -0500
Received: from hera.kernel.org ([140.211.167.34]:39388 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932278AbVLAQAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:00:53 -0500
Date: Thu, 1 Dec 2005 14:00:44 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Better pagecache statistics ?
Message-ID: <20051201160044.GB14499@dmt.cnet>
References: <1133377029.27824.90.camel@localhost.localdomain> <20051201152029.GA14499@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201152029.GA14499@dmt.cnet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 01:20:29PM -0200, Marcelo Tosatti wrote:
> 
> Hi Badari,
> 
> On Wed, Nov 30, 2005 at 10:57:09AM -0800, Badari Pulavarty wrote:
> > Hi,
> > 
> > Is there a effort/patches underway to provide better pagecache
> > statistics ? 
> > 
> > Basically, I am interested in finding detailed break out of
> > cached pages. ("Cached" in /proc/meminfo) 
> > 
> > Out of this "cached pages"
> > 
> > - How much is just file system cache (regular file data) ?
> > - How much is shared memory pages ?
> 
> You could do that from userspace probably, by doing some math 
> on all processes statistics versus global stats, but does not 
> seem very practical.

Actually, SysRQ-M reports "N pages shared".
