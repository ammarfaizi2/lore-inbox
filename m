Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161340AbWHJOEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161340AbWHJOEc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161346AbWHJOEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:04:32 -0400
Received: from sandeen.net ([209.173.210.139]:36195 "EHLO sandeen.net")
	by vger.kernel.org with ESMTP id S1161294AbWHJOEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:04:31 -0400
Message-ID: <44DB3CED.7080802@sandeen.net>
Date: Thu, 10 Aug 2006 09:04:29 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/9] sector_t format string
References: <1155172843.3161.81.camel@localhost.localdomain>	<20060809234019.c8a730e3.akpm@osdl.org>	<Pine.LNX.4.64.0608101302270.6762@scrub.home>	<44DB203A.6050901@garzik.org>	<Pine.LNX.4.64.0608101409350.6762@scrub.home>	<44DB25C1.1020807@garzik.org>	<Pine.LNX.4.64.0608101429510.6762@scrub.home>	<44DB27A3.1040606@garzik.org>	<Pine.LNX.4.64.0608101459260.6761@scrub.home>	<44DB3151.8050904@garzik.org>	<Pine.LNX.4.64.0608101519560.6762@scrub.home>	<44DB34FF.4000303@garzik.org> <Pine.LNX.4.64.0608101547261.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0608101547261.6761@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

> I disagree.
> Many developer still brag about how Linux runs on about everything, but 
> it's little steps like this, which make it more and more a joke.

It does still "run" on most everything but it's naive to think that you can do 
anything and everything on 10-year-old hardware.  Choose ext3 and Linux still 
runs just fine.  And honestly I doubt that ext4 will show much problem either.

ext4 is being developed primarily to address scaling issues at the high end of 
the storage spectrum.  If you're concerned about carrying 64-bit containers, 
just use ext3, and be happy with your 32-bit, < 16TB filesystems, I'd say.

-Eric
