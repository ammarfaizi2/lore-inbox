Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVC0JTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVC0JTx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 04:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVC0JTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 04:19:37 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64148 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261504AbVC0JRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 04:17:52 -0500
Date: Sun, 27 Mar 2005 01:16:30 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] - MPT FUSION - SPLITTING SCSI HOST DRIVERS
Message-ID: <20050327091630.GA938785@sgi.com>
References: <91888D455306F94EBD4D168954A9457C01B70565@nacos172.co.lsil.com> <1111809137.5541.7.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111809137.5541.7.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 09:52:17PM -0600, James Bottomley wrote:
> On Thu, 2005-03-24 at 16:57 -0700, Moore, Eric Dean wrote:
> > +static struct device_attribute mptscsih_queue_depth_attr = {
> > +       .attr = {
> > +               .name =         "queue_depth",
> > +               .mode =         S_IWUSR,
> > +       },
> > +       .store = mpt_core_store_queue_depth,
> > +};
> 
> But in the original which you're removing, this was implemented via the
> change_queue_depth API.
> 
> It looks like the patches you're posting are actually an older version
> of the fusion driver.   Do you have the split done on a current copy?
> 
> Thanks,
> 
> James

James, actually this queue depth code predates your change_queue_depth
API.  I don't think it was ever converted to the new API.

jeremy
