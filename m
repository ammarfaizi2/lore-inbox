Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUCDDpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 22:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUCDDpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 22:45:40 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:60863 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S261418AbUCDDpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 22:45:38 -0500
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
	end)
From: Peter Zaitsev <peter@mysql.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040303193343.52226603.akpm@osdl.org>
References: <20040228072926.GR8834@dualathlon.random>
	 <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
	 <20040229014357.GW8834@dualathlon.random>
	 <1078370073.3403.759.camel@abyss.local>
	 <20040303193343.52226603.akpm@osdl.org>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1078371876.3403.810.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Mar 2004 19:44:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-03 at 19:33, Andrew Morton wrote:



> > 
> > For Disk Bound workloads (200 Warehouse) I got 1250TPM for "hugemem" vs
> > 1450TPM for "smp" kernel, which is some 14% slowdown.
> 
> Please define these terms.  What is the difference between "hugemem" and
> "smp"?

Andrew,


Sorry if I was unclear.  These are suffexes from RH AS 3.0 kernel
namings.  "SMP" corresponds to normal SMP kernel they have,  "hugemem"
is kernel with 4G/4G split.

> 
> > For CPU bound load (10 Warehouses) I got 7000TPM instead of 4500TPM,
> > which is over 35% slowdown.
> 
> Well no, it is a 56% speedup.   Please clarify.  Lots.

Huh. The numbers shall be other way around of course :)   "smp" kernel
had better performance of some 7000TPM, compared to  4500TPM with
HugeMem kernel. 

Swap was disable in both cases. 


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

