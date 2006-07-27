Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWG0Npe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWG0Npe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWG0Npe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:45:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:23226 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161068AbWG0Npe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:45:34 -0400
X-IronPort-AV: i="4.07,187,1151910000"; 
   d="scan'208"; a="105852235:sNHT16424940"
Message-ID: <44C8C37B.50405@intel.com>
Date: Thu, 27 Jul 2006 21:45:31 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Question about ext3 jbd module
References: <CA502B3E9EE27B4490C87C12E3C7C85111D033@pdsmsx412.ccr.corp.intel.com> <1154007033.4941.2.camel@sisko.sctweedie.blueyonder.co.uk>
In-Reply-To: <1154007033.4941.2.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System crashed in RHEL4 U3 version, I doubt why there is no judgement
about whether jh is NULL or not in function journal_dirty_metadata().


thanks
bibo,mao

Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, 2006-07-25 at 17:59 +0800, Mao, Bibo wrote:
>  > Yes, kernel version is 2.6.9, it is OS distribution kernel RHEL4.
> 
> Which version?  There were a few upstream problems like this fixed in
> 2.6.11 or so, and I think current RHEL-4 updates should include those.
> 
> I'm off on holiday/family wedding tomorrow for a couple of weeks, so
> replies might be slow...
> 
> --Stephen
> 
