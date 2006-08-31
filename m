Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWHaRCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWHaRCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWHaRCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:02:33 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:65433 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932211AbWHaRCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:02:32 -0400
Date: Thu, 31 Aug 2006 10:01:56 -0700
From: Paul Jackson <pj@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, haveblue@us.ibm.com,
       apw@shadowen.org, ak@muc.de, benh@kernel.crashing.org, paulus@samba.org,
       kmannth@gmail.com, tony.luck@intel.com, kamezawa.hiroyu@jp.fujitsu.com,
       y-goto@jp.fujitsu.com
Subject: Re: x86_64 account-for-memmap patch in 2.6.18-rc4-mm3 doesn't boot.
Message-Id: <20060831100156.24fc0521.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608311650410.13392@skynet.skynet.ie>
References: <20060831034638.4bfa7b46.pj@sgi.com>
	<Pine.LNX.4.64.0608311650410.13392@skynet.skynet.ie>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel wrote:
> Have you any idea why the console garbling is happening?

Yeah - you're right - it's garbled.  Looks like its dropping chars.

I don't know why, but I'm not surprised.  It's a lab system with a
new (for us) way of rigging the console output.  I just got this
particular x86_64's console connection to work at all yesterday.

I've been working indirectly through my good lab tech.  I should
drive in to the lab that has this rig (an hour away) and check it
out in person, and see what can be done to get clean console output.

This may take a day or three to yield results, unless I get lucky.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
