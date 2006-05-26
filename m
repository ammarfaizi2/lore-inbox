Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWEZS0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWEZS0b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWEZS0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:26:31 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:55687 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1751244AbWEZS0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:26:31 -0400
Date: Fri, 26 May 2006 19:26:20 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: dummy@vaio.testbed.de
To: Christian Kujau <evil@g-house.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: SCSI ABORT with 2.6.17-rc4-mm1
In-Reply-To: <Pine.NEB.4.64.0605200137230.4276@vaio.testbed.de>
Message-ID: <Pine.NEB.4.64.0605261919200.9385@vaio.testbed.de>
References: <62331.192.18.1.5.1148071784.squirrel@housecafe.dyndns.org>
 <20060519141032.23de6eee.akpm@osdl.org> <Pine.NEB.4.64.0605200058040.4276@vaio.testbed.de>
 <Pine.NEB.4.64.0605200137230.4276@vaio.testbed.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just in case the news didn't get through: the issue has been fixed in 
-mm3. I'm not sure about what the real fix was, since

  - rc4 is working
  - rc4-mm1 is not working
  - rc4-mm2 is not working
  - rc4-mm3 is working

Mel Gorman sent me the zonesizing-v13 patch for -mm3 (thanks again!), 
which was also working, results are here:

http://nerdbynature.de/bits/2.6.17-rc4-mm3/

Thanks to all involved,
Christian.
-- 
BOFH excuse #435:

Internet shut down due to maintenance
