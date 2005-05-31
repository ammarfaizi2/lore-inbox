Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVEaPLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVEaPLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVEaPLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:11:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61314 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261901AbVEaPJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:09:36 -0400
Date: Tue, 31 May 2005 17:07:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ #3
Message-ID: <20050531150727.GG7074@suse.de>
References: <20050531124659.GB1530@suse.de> <429C7D2C.9080703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C7D2C.9080703@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >- (libata) import an error handling fix from Hannes.
> 
> Keep this separate, his fix is busted.  Calling scsi_eh_abort_cmds() 
> without an abort handler is highly ineffective, and highly silly.

Irk, I didn't follow the recent discussion. I'll kill the fix locally
for now.

> >Jeff, I'll update your ncq branch at the end of this week if you don't
> >beat me to it.
> 
> Just an incremental patch will do it :)

Ok, will get you on.

-- 
Jens Axboe

