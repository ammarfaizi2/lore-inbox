Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTJWW7a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 18:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTJWW7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 18:59:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:43682 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261863AbTJWW73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 18:59:29 -0400
Date: Thu, 23 Oct 2003 15:59:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: daniel@osdl.org, linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       pbadari@us.ibm.com, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: Patch for Retry based AIO-DIO (Was AIO and DIO testing on
 2.6.0-test7-mm1)
Message-Id: <20031023155937.41b0eeda.akpm@osdl.org>
In-Reply-To: <20031023135030.GA11807@in.ibm.com>
References: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net>
	<20031020142727.GA4068@in.ibm.com>
	<1066693673.22983.10.camel@ibm-c.pdx.osdl.net>
	<20031021121113.GA4282@in.ibm.com>
	<1066869631.1963.46.camel@ibm-c.pdx.osdl.net>
	<20031023104923.GA11543@in.ibm.com>
	<20031023135030.GA11807@in.ibm.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> It turns out that backing out gcc-Os.patch (on RH 9) or switching 
> to a system with an older compiler version made those errors go away.

Ho hum, so we have our answer.

Adrian, how do you feel about slotting this under CONFIG_EMBEDDED?

