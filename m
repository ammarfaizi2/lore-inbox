Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVDDSj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVDDSj2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 14:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVDDSjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 14:39:22 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:35298 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261327AbVDDSjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 14:39:15 -0400
Subject: Re: [PATCH scsi-misc-2.6 08/13] scsi: move request preps in other
	places into prep_fn()
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050401052542.GG11318@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org>
	 <20050331090647.94FFEC1E@htj.dyndns.org>
	 <1112292464.5619.30.camel@mulgrave> <20050401052542.GG11318@htj.dyndns.org>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 13:39:04 -0500
Message-Id: <1112639944.5813.66.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 14:25 +0900, Tejun Heo wrote:
>  Ah.. with later requeue path consolidation patches, all requests get
> their sense buffer cleared during requeueing, which, IMHO, is more
> logical.  Moving scsi_init_cmd_errh() should come after the patch.
> Sorry. :-)
> 
>  I'll make another take of this patchset (maybe subset) after issues
> are resolved.  I'll split and reorder relocation of scsi_init_cmd_errh
> then.

Thanks.  It would help me enormously if you explained what bugs you were
fixing at the top of each patch, and also only do patchsets that are
dependent on each other (I already have your serial_numer_at_timeout and
internal_timeout removal patches in the scsi-misc-2.6 tree).

James


