Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWEEXNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWEEXNU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 19:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWEEXNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 19:13:20 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:2231 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750955AbWEEXNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 19:13:20 -0400
Date: Fri, 05 May 2006 17:12:45 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: High load average on disk I/O on 2.6.17-rc3
In-reply-to: <69c8K-3Bu-57@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: jasons@pioneer-pra.com
Message-id: <445BDBED.7050101@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <69c8K-3Bu-57@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Schoonover wrote:
> Hi all,
> 
> I'm not sure if this is the right list to post to, so please direct me to the 
> appropriate list if this is the wrong one.
> 
> I'm having some problems on the latest 2.6.17-rc3 kernel and SCSI disk I/O.  
> Whenever I copy any large file (over 500GB) the load average starts to slowly 
> rise and after about a minute it is up to 7.5 and keeps on rising (depending 
> on how long the file takes to copy).  When I watch top, the processes at the 
> top of the list are cp, pdflush, kjournald and kswapd.
> 

Are there some processes stuck in D state? These will contribute to the 
load average even if they are not using CPU.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

