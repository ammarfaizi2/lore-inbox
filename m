Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbUAPNn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 08:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbUAPNn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 08:43:58 -0500
Received: from lists.us.dell.com ([143.166.224.162]:61622 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265445AbUAPNnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 08:43:55 -0500
Date: Fri, 16 Jan 2004 07:43:36 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Scott Long <scott_long@adaptec.com>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040116074336.A12893@lists.us.dell.com>
References: <40033D02.8000207@adaptec.com> <16389.52150.148792.875315@notabene.cse.unsw.edu.au> <20040115155221.A31378@lists.us.dell.com> <20040116092447.GF22417@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040116092447.GF22417@marowsky-bree.de>; from lmb@suse.de on Fri, Jan 16, 2004 at 10:24:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 10:24:47AM +0100, Lars Marowsky-Bree wrote:
> Do you know whether DDF can also support simple multipathing?

Yes, the structure info for each physical disk allows for two (and
only 2) paths to be represented.  But it's pretty limited, describing
only SCSI-like paths with bus/id/lun only described in the current
draft.  At the same time, there's a per-physical-disk GUID, such
that if you find the same disk by multiple paths you can tell.
There's room for enhancment/feedback in this space for certain.  

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
