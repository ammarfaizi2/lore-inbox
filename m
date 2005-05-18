Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVERPEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVERPEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVERPBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:01:49 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:51131 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262246AbVEROav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:30:51 -0400
Date: Wed, 18 May 2005 20:10:34 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, gregoire.favre@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050518144034.GB3937@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050516085832.GA9558@gmail.com> <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org> <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com> <1116354894.4989.42.camel@mulgrave> <20050518090722.GA3937@in.ibm.com> <1116425559.5027.1.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116425559.5027.1.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 09:12:39AM -0500, James Bottomley wrote:
> > 
> > So are these patches getting into -mm first or -rc5 ??
> 
> Damn, I knew you were going to ask that ... the problem is it's the last
> in a long line of invasive adaptec patches that sit in my scsi-misc-2.6
> tree ... I suppose we can't have the aic driver slightly hosed for
> 2.6.12; I'll see if I can extract them.
> 

You actually thought you could get away with that ?? :)

Seriously, scsi takes a long time to boot even normally, but with this
bug, it takes forever and a few more retries before it finally boots up.

I would really appreciate if you could extract and send them upstream,
Thanks

	-Dinakar
