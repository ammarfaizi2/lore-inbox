Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVCNGVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVCNGVa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 01:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVCNGV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 01:21:29 -0500
Received: from stark.xeocode.com ([216.58.44.227]:39815 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261919AbVCNGVY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 01:21:24 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Greg Stark <gsstark@MIT.EDU>, s0348365@sms.ed.ac.uk,
       linux-kernel@vger.kernel.org, pmcfarland@downeast.net
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
References: <87u0ng90mo.fsf@stark.xeocode.com>
	<200503130152.52342.pmcfarland@downeast.net>
	<874qff89ob.fsf@stark.xeocode.com>
	<200503140103.55354.s0348365@sms.ed.ac.uk>
	<87sm2y7uon.fsf@stark.xeocode.com>
	<20050313200753.20411bdb.akpm@osdl.org>
	<87br9m7s8h.fsf@stark.xeocode.com> <87zmx66b2b.fsf@stark.xeocode.com>
	<20050313215710.5fa920d4.akpm@osdl.org>
In-Reply-To: <20050313215710.5fa920d4.akpm@osdl.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 14 Mar 2005 01:21:15 -0500
Message-ID: <87r7ii6944.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> The 2.6.6 i810_audio.c compiles OK in current kernels with the below patch
> applied.  

This would be a good time to learn the right way to do this: how do I build a
driver from a kernel tree without building the whole tree?

Like, if I copy the 2.6.6 drivers to a new directory outside a kernel tree, is
there some magic make command I can give it to point it at the 2.6.10 tree for
the build environment including make includes and header files?

-- 
greg

