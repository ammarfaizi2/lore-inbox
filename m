Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbTCTITq>; Thu, 20 Mar 2003 03:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbTCTITq>; Thu, 20 Mar 2003 03:19:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45486 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261320AbTCTITo>;
	Thu, 20 Mar 2003 03:19:44 -0500
Date: Thu, 20 Mar 2003 00:29:04 -0800 (PST)
Message-Id: <20030320.002904.73362328.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] cleanup nicstar, suni and idt77105 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200303091239.h29CdkGi000928@locutus.cmf.nrl.navy.mil>
References: <20030308.130112.09061347.davem@redhat.com>
	<200303091239.h29CdkGi000928@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Sun, 09 Mar 2003 07:39:46 -0500

   In message <20030308.130112.09061347.davem@redhat.com>,"David S. Miller" writes:
   >This patch doesn't apply at all, it deletes lines referencing
   >idt77105_priv_lock but that does not appear in the sources.
   
   yes that's my fault.  i had an intermediate change i forgot about.
   this would be the correct diff for idt77105 --
   
When I reject a patch, I typically just delete everything you
sent me, so if you just resend one part of the fixed up patch
the rest gets lost.

Can you send the correct patch for all three drivers not just
the idt77105 parts?

It really isn't rocket science to send patches properly.  When I say
"didn't apply" it means it went to /dev/null and you have to send me
a new complete patch.
