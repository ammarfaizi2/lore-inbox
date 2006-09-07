Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWIGPVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWIGPVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWIGPVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:21:44 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:59662 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S932084AbWIGPVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:21:43 -0400
Date: Thu, 7 Sep 2006 17:21:35 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rc6] ext3 memory leak
In-Reply-To: <Pine.LNX.4.63.0609071300330.1700@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.63.0609071657490.1700@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0609071300330.1700@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006, Guennadi Liakhovetski wrote:

> I've reported before in thread "[2.6.17.4] slabinfo.buffer_head increases" a 
> memory leak in ext3. Today I verified it is still present in 2.6.18-rc6.

No, sorry, I cannot seem to reproduce it under -rc6. It seems to stabilize 
eventually. But it doesn't under -rc2. I looked through all commits to 
ext3 code between -rc2 and -rc6 and I don't see any obvious reasons why a 
memory leak may have been fixed. Unless somebody can sched some light on 
this, I'll try to upgrade the problematic system to -rc6 tomorrow.

Just to be quite sure - this cannot (or is very unlikely to) be a libc 
bug, right?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
