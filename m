Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVIGKts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVIGKts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 06:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVIGKts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 06:49:48 -0400
Received: from verein.lst.de ([213.95.11.210]:32413 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932107AbVIGKtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 06:49:47 -0400
Date: Wed, 7 Sep 2005 12:49:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Santiago Leon <santil@us.ibm.com>,
       Linda Xie <lxiep@us.ibm.com>
Subject: Re: [RFC] SCSI target for IBM Power5 LPAR
Message-ID: <20050907104932.GA14200@lst.de>
References: <20050906212801.GB14057@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906212801.GB14057@cs.umn.edu>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 04:28:01PM -0500, Dave C Boutcher wrote:
> This device driver provides the SCSI target side of the "virtual
> SCSI" on IBM Power5 systems.  The initiator side has been in mainline
> for a while now (drivers/scsi/ibmvscsi/ibmvscsi.c.)  Targets already
> exist for AIX and OS/400.

Please try to integrate that with the generic scsi target framework at
http://developer.berlios.de/projects/stgt/.

