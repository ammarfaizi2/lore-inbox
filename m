Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUITUUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUITUUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUITUUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:20:42 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:42769 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S264639AbUITUUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:20:38 -0400
Date: Mon, 20 Sep 2004 15:20:09 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mike.miller@hp.com, linux-kernel@vger.kernel.org, axboe@suse.de,
       linux-scsi@vger.kernel.org
Subject: Re: fix for cpqarray for 2.6.9-rc2
Message-ID: <20040920202009.GA6443@beardog.cca.cpqcorp.net>
References: <20040920192420.GA5651@beardog.cca.cpqcorp.net> <414F3377.9080106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414F3377.9080106@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 03:45:59PM -0400, Jeff Garzik wrote:
> mike.miller@hp.com wrote:
> >diff -burNp lx269-rc2.orig/drivers/block/ida_cmd.h 
> >lx269-rc2/drivers/block/ida_cmd.h
> >--- lx269-rc2.orig/drivers/block/ida_cmd.h	2004-08-14 
> >00:36:44.000000000 -0500
> >+++ lx269-rc2/drivers/block/ida_cmd.h	2004-09-20 14:15:39.782595128 -0500
> >@@ -318,6 +318,8 @@ typedef struct {
> > 	__u8	reserved[510];
> > } mp_delay_t;
> > 
> >+#define SENSE_SURF_STATUS       0x70
> 
> 
> I guess the return codes for this op are along the lines of "calm", 
> "bitchin", and "gnarly"?
> 
> 	Jeff

Hint taken, Chirag pls return something meaningful.

mikem
> 
> 
