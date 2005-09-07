Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVIGTfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVIGTfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 15:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVIGTfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 15:35:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47884 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932236AbVIGTfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 15:35:16 -0400
Date: Wed, 7 Sep 2005 21:35:18 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] SCSI merge for 2.6.13
Message-ID: <20050907193517.GT4785@suse.de>
References: <1126053452.5012.28.camel@mulgrave> <20050907174744.GA13172@us.ibm.com> <1126116850.4823.31.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126116850.4823.31.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07 2005, James Bottomley wrote:
> On Wed, 2005-09-07 at 10:47 -0700, Patrick Mansfield wrote:
> > The scsi_execute() retries argument is still not used.
> 
> Yes, Jens was thinking about how to add this to the block layer.

Yeah we probably have to, FAILFAST just doesn't cover all the needed
cases.

-- 
Jens Axboe

