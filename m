Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTJWXZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTJWXZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:25:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:46258 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261882AbTJWXZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:25:45 -0400
Date: Thu, 23 Oct 2003 16:25:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: suparna@in.ibm.com, daniel@osdl.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: Patch for Retry based AIO-DIO (Was AIO and DIO testing
 on2.6.0-test7-mm1)
Message-Id: <20031023162539.0051249d.akpm@osdl.org>
In-Reply-To: <20031023232006.GH21490@fs.tum.de>
References: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net>
	<20031020142727.GA4068@in.ibm.com>
	<1066693673.22983.10.camel@ibm-c.pdx.osdl.net>
	<20031021121113.GA4282@in.ibm.com>
	<1066869631.1963.46.camel@ibm-c.pdx.osdl.net>
	<20031023104923.GA11543@in.ibm.com>
	<20031023135030.GA11807@in.ibm.com>
	<20031023155937.41b0eeda.akpm@osdl.org>
	<20031023232006.GH21490@fs.tum.de>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> On Thu, Oct 23, 2003 at 03:59:37PM -0700, Andrew Morton wrote:
> > Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> > >
> > > It turns out that backing out gcc-Os.patch (on RH 9) or switching 
> > > to a system with an older compiler version made those errors go away.
> > 
> > Ho hum, so we have our answer.
> > 
> > Adrian, how do you feel about slotting this under CONFIG_EMBEDDED?
> 
> That was in the first version of the patch, but Christoph Hellwig asked 
> to drop the EMBEDDED.

That was before we knew that it craps out when compiled on RH9.

