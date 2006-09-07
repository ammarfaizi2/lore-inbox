Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWIGPds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWIGPds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWIGPds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:33:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21680 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932097AbWIGPdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:33:46 -0400
Date: Thu, 7 Sep 2006 08:33:08 -0700
From: Paul Jackson <pj@sgi.com>
To: mel@skynet.ie (Mel Gorman)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, haveblue@us.ibm.com,
       apw@shadowen.org, ak@muc.de, benh@kernel.crashing.org, paulus@samba.org,
       kmannth@gmail.com, tony.luck@intel.com, kamezawa.hiroyu@jp.fujitsu.com,
       y-goto@jp.fujitsu.com
Subject: Re: [PATCH] Fix memmap accounting by approximating the map size
Message-Id: <20060907083308.45e2aec6.pj@sgi.com>
In-Reply-To: <20060907142744.GA31799@skynet.ie>
References: <20060831034638.4bfa7b46.pj@sgi.com>
	<Pine.LNX.4.64.0608311650410.13392@skynet.skynet.ie>
	<20060831100156.24fc0521.pj@sgi.com>
	<Pine.LNX.4.64.0609010933220.25057@skynet.skynet.ie>
	<20060901202430.0681f5c5.pj@sgi.com>
	<20060904094503.GA4475@skynet.ie>
	<20060906151008.e84ffdd1.pj@sgi.com>
	<Pine.LNX.4.64.0609071502001.31287@skynet.skynet.ie>
	<20060907142744.GA31799@skynet.ie>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel wrote:
> This patch ditches the account_memmap() complexity and replaces with the
> simple approximation used by x86_64 while ensuring no underflow occurs.

Works for me, on my x86_64 box.  Thanks, Mel.

Acked-by: Paul Jackson <pj@sgi.com>

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
