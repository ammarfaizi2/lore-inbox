Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVCOJ2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVCOJ2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 04:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVCOJ2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 04:28:41 -0500
Received: from orb.pobox.com ([207.8.226.5]:32967 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262358AbVCOJ2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 04:28:33 -0500
Date: Tue, 15 Mar 2005 01:28:25 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Dan Stromberg <strombrg@dcs.nac.uci.edu>, linux-kernel@vger.kernel.org
Subject: Re: huge filesystems
Message-ID: <20050315092825.GA14209@ip68-4-98-123.oc.oc.cox.net>
References: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu> <20050314164137.GC1451@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314164137.GC1451@schnapps.adilger.int>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 11:41:37AM -0500, Andreas Dilger wrote:
> > What about the "LBD" patches - what limits are involved there, and have
> > they been rolled into a Linus kernel, or one or more vendor kernels?
> 
> These are part of stock 2.6 kernels.  The caveat here is that there have
> been some problems reported (with ext3 at least) for filesystems > 2TB
> so I don't think it has really been tested very much.

FWIW Red Hat appears to officially support 8TB ext3 filesystems on
Red Hat Enterprise Linux 4:

"Ext3 scalability: Dynamic file system expansion and file system sizes
up to 8TB are now supported."

http://www.redhat.com/software/rhel/features/

-Barry K. Nathan <barryn@pobox.com>
