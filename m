Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUITX2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUITX2V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 19:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUITX2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 19:28:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23212 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267385AbUITX2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 19:28:17 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: 2.6.9-rc2-mm1
Date: Mon, 20 Sep 2004 16:27:56 -0700
User-Agent: KMail/1.7
Cc: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
       len.brown@intel.com, tony.luck@intel.com, jes@wildopensource.com,
       linux-kernel@vger.kernel.org, andrew.vasquez@qlogic.com
References: <20040916024020.0c88586d.akpm@osdl.org> <20040920011231.GP9106@holomorphy.com> <20040919213706.4b8083e8.pj@sgi.com>
In-Reply-To: <20040919213706.4b8083e8.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409201627.57051.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 19, 2004 9:37 pm, Paul Jackson wrote:
> wli wrote:
> > Fails to boot on my Altix.
>
> See a couple of patches on this linux-scsi thread, mostly between Jesse
> Barnes and Andrew Vasquez:
>
>  SCSI QLA not working on latest *-mm SN2
>  http://marc.theaimsgroup.com/?l=linux-scsi&m=109537406715003&w=2
>
> Or I got it working (I think - memory fuzzy know) without this patch, by
> (1) disabling the CONFIG_SCSI_QLA2[123]?? options, and (2) applying the
> following workaround patch:

You'll need the patch you posted (or its equivalent, see my earlier reply to 
Andrew's announcement) to boot.  You'll need the qla patches I posted to use 
qla2xxx adapters.

Jesse
