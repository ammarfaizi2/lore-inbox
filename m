Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVCNR2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVCNR2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVCNR2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:28:12 -0500
Received: from zeus.kernel.org ([204.152.189.113]:44026 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261634AbVCNR2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:28:05 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Date: Mon, 14 Mar 2005 09:27:20 -0800
User-Agent: KMail/1.7.2
Cc: Pavel Machek <pavel@ucw.cz>, David Lang <david.lang@digitalinsight.com>,
       Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <200503140855.18446.jbarnes@engr.sgi.com> <Pine.LNX.4.58.0503140907380.6119@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503140907380.6119@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503140927.21552.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 14, 2005 9:18 am, Linus Torvalds wrote:
> In fact, even the ones that have no "information" end up often being a big
> clue about where the hang happened.

Yeah, I use the startup output all the time for stuff like that, no question 
it's useful.

> And those occasional people are often not going to eb very good at
> reporting bugs. If they don't see anything happening, they'll just give up
> rather than bother to report it. So I do think we want the fairly verbose
> thing enabled by default. You can then hide it with the graphical bootup
> for "most people".

Ok, and for the development kernel that makes a lot of sense.  But as we've 
seen from this thread, leaving in old printks that were once useful but no 
longer are tends to clutter things up and hide real errors.  I'd like to see 
us get better about that--reporting real errors better and keeping the junk 
to a minimum.

Jesse
