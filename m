Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbUKENnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUKENnw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 08:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUKENnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 08:43:51 -0500
Received: from unthought.net ([212.97.129.88]:24256 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262686AbUKENns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 08:43:48 -0500
Date: Fri, 5 Nov 2004 14:43:46 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
Message-ID: <20041105134346.GD12752@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
References: <41877751.502@wasp.net.au> <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com> <20041102200925.GA12752@unthought.net> <418AE9DD.3010008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418AE9DD.3010008@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 09:47:57PM -0500, Jeff Garzik wrote:
> Jakob Oestergaard wrote:
...
> >
> >Hi Jeff,
> >
> >Does running an 'ls' on the server in the exported directory that is
> >stale on the client resolve the problem (temporarily)?
> 
> Yes.
> 

Hah!  Is that weird, or is that weird?   :)

Probably whoever wants to look into this might want to get in touch with
Anders as well:
 http://lkml.org/lkml/2004/11/2/107

A quick workaround is to have cron run an 'ls' for you in the exported
directory on the server side - b-e-a-utiful!  :)

-- 

 / jakob

