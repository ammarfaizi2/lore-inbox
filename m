Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264345AbTLESyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264347AbTLESye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:54:34 -0500
Received: from lists.us.dell.com ([143.166.224.162]:15010 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264345AbTLESy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:54:28 -0500
Date: Fri, 5 Dec 2003 12:53:51 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Meelis Roos <mroos@linux.ee>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
Message-ID: <20031205125351.A22277@lists.us.dell.com>
References: <Pine.SOL.4.58.0312042225300.26114@yellow.csi.cam.ac.uk> <Pine.LNX.4.44.0312051109580.1782-100000@logos.cnet> <20031205113619.A20371@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031205113619.A20371@lists.us.dell.com>; from Matt_Domsch@dell.com on Fri, Dec 05, 2003 at 11:36:19AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, that's my bad, setup.c should say DISK80_SIG_BUFFER not
> DISKSIG_BUFFER.

BK patch to fix that:
Marcelo, please do a

	bk pull http://mdomsch.bkbits.net/linux-2.4-edd

This will update the following files:

 arch/i386/kernel/edd.c   |    2 +-
 arch/i386/kernel/setup.c |    2 +-
 2 files changed, 2 insertions, 2 deletions

through these ChangeSets:

<Matt_Domsch@dell.com> (03/12/05 1.1199)
   EDD: s/DISKSIG_BUFFER/DISK80_SIG_BUFFER so it compiles
   
   bump EDD version number.


Tested on my PowerEdge 4600.

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
