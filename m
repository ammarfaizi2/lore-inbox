Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTIWH5l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 03:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263326AbTIWH5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 03:57:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63176 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263275AbTIWH5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 03:57:40 -0400
Date: Tue, 23 Sep 2003 08:57:36 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Joe Thornber <ethornber@yahoo.co.uk>
Cc: Kevin Corry <kevcorry@us.ibm.com>, torvalds@osdl.org, akpm@zip.com.au,
       thornber@sistina.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DM 1/6: Use new format_dev_t macro
Message-ID: <20030923075736.GK7665@parcelfarce.linux.theplanet.co.uk>
References: <20030922192909.GG7665@parcelfarce.linux.theplanet.co.uk> <877B4BDE-ED9B-11D7-BE69-000393CA5730@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877B4BDE-ED9B-11D7-BE69-000393CA5730@yahoo.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 08:57:07AM +0100, Joe Thornber wrote:
> 
> On Monday, September 22, 2003, at 08:29 PM, 
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> >On Mon, Sep 22, 2003 at 10:51:27AM -0500, Kevin Corry wrote:
> >>Use the format_dev_t function for target status functions.
> >
> >[instead of bdevname, that is]
> >
> >It's wrong.  Simply because "sdb3" is immediately parsed by admin and
> >08:13 is nowhere near that convenient.  These are error messages, let's
> >keep them readable.
> >
> >
> 
> No they are not just error messages, userland tools use them.

In which case the change in question would break said userland tools, wouldn't
it?
