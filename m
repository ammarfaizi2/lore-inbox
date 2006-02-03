Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946037AbWBCXVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946037AbWBCXVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946080AbWBCXVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:21:10 -0500
Received: from zrtps0kp.nortel.com ([47.140.192.56]:8143 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP
	id S1946037AbWBCXVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:21:09 -0500
Message-ID: <43E3E55C.90504@nortel.com>
Date: Fri, 03 Feb 2006 17:21:00 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: how to limit memory with 2.6.10 on ppc64 machine?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2006 23:21:02.0286 (UTC) FILETIME=[7F91E6E0:01C62918]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running 2.6.10 on a ppc64 machine with 4GB of memory.

We're debugging an issue and would like to try and see if disabling the 
U3 DART makes the problem go away.  Unfortunately, this particular blade 
is unstable if not all the memory banks are populated.

After some frustration I looked at the code and realized that the "mem=" 
functionality is not supported for ppc64 on this particular kernel.

Can anyone give me some advice on the simplest way to limit this thing 
to under 2GB of memory so that the DART is not allocated/used?

Does anyone know when support for "mem=" was added?  I know it is there 
in the current git version, but the "powerpc" consolidation means 
everything is all different now.

Thanks,

Chris
