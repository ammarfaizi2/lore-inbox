Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbTIKSi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 14:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbTIKSi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 14:38:26 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:33851 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S261438AbTIKSiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 14:38:25 -0400
Message-ID: <3F60BF89.6060605@rackable.com>
Date: Thu, 11 Sep 2003 11:31:37 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yaoping Ruan <yruan@CS.Princeton.EDU>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux on Intel Server Board SE7501WV2
References: <Pine.GSO.4.55.0309111338120.28288@oakley.CS.Princeton.EDU>
In-Reply-To: <Pine.GSO.4.55.0309111338120.28288@oakley.CS.Princeton.EDU>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2003 18:38:22.0116 (UTC) FILETIME=[E0A85640:01C37893]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaoping Ruan wrote:
> Hello,
> 
> We plan to install Linux (2.4.21 and later with epoll patch) on an Intel
> Server Board SE7501WV2 with 1 XEON 2.4GHz CPU, 4GB PC2100 DDR memory, and
> a Seagate 120GB ATA 7200RPM harddisk, and use the server box for high
> demand SpecWeb99 tests. Does anyone have any experience on this Server
> Board, and see any compatibility problem here?

    No it should just work on 2.4.21.  You may want to try 2.4.22 if you 
aren't using dma on harddrive. "hdparm -d /dev/hda"
> 
> An other question about this box is the two on-board Gigabit Network
> Controller. Do they work fine on Linux? 

   Yes with newer versions of the e1000 driver.  (2.4.21 should be new 
enough.)  Newer kernel revs may have issues networking issues if you are 
enabling acpi.  Try "pci=noacpi" if you have issues.


> May I use fiber Giganet NCI like
> Netgear GA621 on it?

> 
> Any thoughts/information are welcome.
> 
> 

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

