Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSLMIeI>; Fri, 13 Dec 2002 03:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSLMIeH>; Fri, 13 Dec 2002 03:34:07 -0500
Received: from cmailg2.svr.pol.co.uk ([195.92.195.172]:42766 "EHLO
	cmailg2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261593AbSLMIeH>; Fri, 13 Dec 2002 03:34:07 -0500
Date: Fri, 13 Dec 2002 08:41:52 +0000
To: lvm-devel@sistina.com
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Wil Reichert <wilreichert@yahoo.com>, Greg KH <greg@kroah.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [lvm-devel] Re: "bio too big" error
Message-ID: <20021213084152.GA1117@reti>
References: <20021211234557.GF16615@kroah.com> <20021212001542.51940.qmail@web40109.mail.yahoo.com> <20021212091209.GA1299@reti> <02121215511604.05277@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02121215511604.05277@boiler>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 03:51:16PM -0600, Kevin Corry wrote:
> I believe we have tracked the problem down to the call to dm_get_device() in 
> dm-linear.c.

Yes, that'll be it.  Well done.

- Joe
