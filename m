Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWDVRvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWDVRvv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 13:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWDVRvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 13:51:51 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54429 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750823AbWDVRvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 13:51:51 -0400
From: Andi Kleen <ak@suse.de>
To: lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [Patch 8/8] /proc export of aggregated block I/O delays
Date: Sat, 22 Apr 2006 09:46:19 +0200
User-Agent: KMail/1.9.1
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@engr.sgi.com>
References: <444991EF.3080708@watson.ibm.com> <44499809.1000301@watson.ibm.com>
In-Reply-To: <44499809.1000301@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604220946.20010.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 April 2006 04:42, Shailabh Nagar wrote:
> Changelog
> Fixed comments by akpm
> - use __u64 for delayacct_blkio_ticks() return type
> - redundant check for tsk->delays in __delayacct_blkio_ticks()

I think these basic statistics in /proc are quite useful. Hopefully
top etc. would learn quickly about them too so that normal 
people can actually make use of it.

-Andi
