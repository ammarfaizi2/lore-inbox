Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWIHHjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWIHHjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 03:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWIHHjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 03:39:08 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:18701 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1750711AbWIHHjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 03:39:04 -0400
Date: Fri, 8 Sep 2006 09:38:59 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Andrew Morton <akpm@osdl.org>
Cc: sct@redhat.com, adilger@clusterfs.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rc6] ext3 memory leak
In-Reply-To: <20060907093417.54d2adf1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0609080933390.1700@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0609071300330.1700@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0609071657490.1700@pcgl.dsa-ac.de> <20060907093417.54d2adf1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006, Andrew Morton wrote:

> It is expected that in this situation the number of buffer_head objects will
> be approximately equal to the number of pagecache pages.  So once the pagecache
> has grown to consume all available memory and the kernel starts to perform pagecache
> reclaim, the buffer_head count should stabilise.

Ok, thanks that's exactly what I had to know - makes sense now.

Sorry for a false alarm.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
