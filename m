Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWFISIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWFISIe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWFISId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:08:33 -0400
Received: from [80.71.248.82] ([80.71.248.82]:23762 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030280AbWFISIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:08:32 -0400
X-Comment-To: Matthew Frost
To: artusemrys@sbcglobal.net
Cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net>
	<44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net>
	<4489B83E.9090104@sbcglobal.net>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 22:10:36 +0400
In-Reply-To: <4489B83E.9090104@sbcglobal.net> (Matthew Frost's message of "Fri, 09 Jun 2006 13:04:46 -0500")
Message-ID: <m364ja9p43.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Matthew Frost (MF) writes:

 MF> Alex Tomas wrote:
 >>>>>>> Jeff Garzik (JG) writes:
 JG> Think about how this will be deployed in production, long term.
 JG> If extents are not made default at some point, then no one will
 >> use
 JG> the feature, and it should not be merged.
 >> sorry, I disagree. for example, NUMA isn't default and shouldn't be.
 >> but we have it in the tree and any one may choose to use it.

 MF> NUMA is designed to cope with a hardware feature, which not everybody
 MF> has.  Filesystem upgrades are not qualitatively similar; it does not
 MF> depend on one's hardware design as to whether one uses ext3, let alone
 MF> extents.  Your logic is faulty.

proposed 48bit extents patch addresses 2TB limit.


thanks, Alex
