Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVIGMpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVIGMpR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 08:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVIGMpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 08:45:10 -0400
Received: from mail.cs.umn.edu ([128.101.32.202]:13754 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S932134AbVIGMpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 08:45:08 -0400
Date: Wed, 7 Sep 2005 07:45:04 -0500
From: Dave C Boutcher <sleddog@us.ibm.com>
To: Christoph Hellwig <hch@lst.de>, Vladislav Bolkhovitin <vst@vlnb.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Santiago Leon <santil@us.ibm.com>,
       Linda Xie <lxiep@us.ibm.com>
Subject: Re: [RFC] SCSI target for IBM Power5 LPAR
Message-ID: <20050907124504.GA13614@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Vladislav Bolkhovitin <vst@vlnb.net>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linuxppc64-dev@ozlabs.org,
	Santiago Leon <santil@us.ibm.com>, Linda Xie <lxiep@us.ibm.com>
References: <20050906212801.GB14057@cs.umn.edu> <20050907104932.GA14200@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907104932.GA14200@lst.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 12:49:32PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 06, 2005 at 04:28:01PM -0500, Dave C Boutcher wrote:
> > This device driver provides the SCSI target side of the "virtual
> > SCSI" on IBM Power5 systems.  The initiator side has been in mainline
> > for a while now (drivers/scsi/ibmvscsi/ibmvscsi.c.)  Targets already
> > exist for AIX and OS/400.
> 
> Please try to integrate that with the generic scsi target framework at
> http://developer.berlios.de/projects/stgt/.

There hasn't been a lot of forward progress on stgt in over a year, and
there were some issues (lack of scatterlist support, synchronous and
serial command execution) that were an issue when last I looked.

Vlad, can you comment on the state of stgt and whether you see it
being ready for mainline any time soon?

-- 
Dave Boutcher
