Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbUAPNzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 08:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUAPNzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 08:55:42 -0500
Received: from gate.in-addr.de ([212.8.193.158]:37065 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S265465AbUAPNzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 08:55:39 -0500
Date: Fri, 16 Jan 2004 14:56:46 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Scott Long <scott_long@adaptec.com>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040116135646.GD27825@marowsky-bree.de>
References: <40033D02.8000207@adaptec.com> <16389.52150.148792.875315@notabene.cse.unsw.edu.au> <20040115155221.A31378@lists.us.dell.com> <20040116092447.GF22417@marowsky-bree.de> <20040116074336.A12893@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040116074336.A12893@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-01-16T07:43:36,
   Matt Domsch <Matt_Domsch@dell.com> said:

> > Do you know whether DDF can also support simple multipathing?
> Yes, the structure info for each physical disk allows for two (and
> only 2) paths to be represented.  But it's pretty limited, describing
> only SCSI-like paths with bus/id/lun only described in the current
> draft.  At the same time, there's a per-physical-disk GUID, such
> that if you find the same disk by multiple paths you can tell.
> There's room for enhancment/feedback in this space for certain.  

One would guess that for m-p, a mere media UUID would be completely
enough; one can simply scan where those are found.

If it encodes the bus/id/lun, I can forsee bad effects if the device
enumeration changes because the HBAs get swapped in their slots ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

