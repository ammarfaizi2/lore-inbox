Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWAXKIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWAXKIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 05:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWAXKIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 05:08:37 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:51728 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S1030405AbWAXKIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 05:08:37 -0500
From: Meelis Roos <mroos@linux.ee>
To: mloftis@wgops.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
In-Reply-To: <280A351A008C409CEF43A734@dhcp-2-206.wgops.com>
User-Agent: tin/1.8.0-20051224 ("Ronay") (UNIX) (Linux/2.6.16-rc1-g3ee68c4a-dirty (i686))
Message-Id: <20060124100834.7B10913EBF@rhn.tartu-labor>
Date: Tue, 24 Jan 2006 12:08:34 +0200 (EET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ML> You missed the point.  The kernel in OS X maintains creation and use of 
ML> these files automatically.  The point wasn't oh wow multiple files' it was 
ML> that it creates them on the fly.  I just posted back with the apparent new 
ML> method that's being used.  I'm not sure if the 512MB number continues or if 
ML> the next file will be 1Gb or another 512M.  Or of memory size affects it or 
ML> not.

Not in kernel but userspace, seems like Linux:

http://developer.apple.com/documentation/Darwin/Reference/ManPages/man8/dynamic_pager.8.html

     The dynamic_pager daemon manages a pool of external swap files which the
     kernel uses to support demand paging.  This pool is expanded with new
     swap files as load on the system increases, and contracted when the swap-swapping
     ping resources are no longer needed.  The dynamic_pager daemon also pro-provides
     vides a notification service for those applications which wish to receive
     notices when the external paging pool expands or contracts.

-- 
Meelis Roos
