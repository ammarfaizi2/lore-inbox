Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268167AbUJDONp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268167AbUJDONp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUJDOMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:12:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50916 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268139AbUJDOMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:12:41 -0400
Date: Mon, 4 Oct 2004 12:43:50 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mitch <Mitch@0Bits.COM>
Cc: ottdot@magma.ca, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Message-ID: <20041004104350.GA3833@openzaurus.ucw.cz>
References: <416030C0.8090900@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416030C0.8090900@0Bits.COM>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Well it appears that Jesse and Kevin are right and irrespective of 
> the setting of /sys/power/disk, i can get the machine to suspend by 
> first writing 'platform' into the 'disk' file. And it resumes fine 
> ok. Seems to be a false alarm on my part Pavel, although the doc's 
> need updating and /sys/power/disk made to show the correct supported 
> suspension methods ?

It seemed to me that some driver is blocking suspend (USB?). I do not
know what is wrong with that disk file, it looks like a bug.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

