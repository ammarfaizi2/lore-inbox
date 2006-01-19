Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161305AbWASTHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161305AbWASTHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161310AbWASTHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:07:23 -0500
Received: from host233.omnispring.com ([69.44.168.233]:30931 "EHLO
	iradimed.com") by vger.kernel.org with ESMTP id S1161305AbWASTHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:07:21 -0500
Message-ID: <43CFE34F.8060309@cfl.rr.com>
Date: Thu, 19 Jan 2006 14:06:55 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
CC: govind raj <agovinda04@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID 5+0 support
References: <BAY109-F267E92D32B75385FDB680DD61C0@phx.gbl> <43CFCBB2.3050003@cfl.rr.com> <Pine.LNX.4.60.0601191933250.14341@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0601191933250.14341@kepler.fjfi.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2006 19:08:10.0349 (UTC) FILETIME=[B031C9D0:01C61D2B]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.51.1032-14215.000
X-TM-AS-Result: No--0.900000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drab wrote:
> Speed is the issue here, I believe. By stripping two RAID-5 arrays you 
> ought to get the reliability of the RAID-5 but with considerably higher 
> speed. That's basically why RAID-50 exists, I think.

One big raid-5 would have higher speed because it would have one more 
disk allocated to storing data rather than more parity.  The raid 5+0 
isn't really going to be any more reliable because it can withstand a 
single failure in either half, but not two failures in one half, so in 
the face of a double failure, you have a 50/50 chance of one being in 
each half. 



