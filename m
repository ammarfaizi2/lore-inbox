Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbTABLAJ>; Thu, 2 Jan 2003 06:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbTABLAJ>; Thu, 2 Jan 2003 06:00:09 -0500
Received: from are.twiddle.net ([64.81.246.98]:46211 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S261322AbTABLAI>;
	Thu, 2 Jan 2003 06:00:08 -0500
Date: Thu, 2 Jan 2003 03:06:20 -0800
From: Richard Henderson <rth@twiddle.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [TGAFB] implement more acceleration hooks; fbdev merge error
Message-ID: <20030102030620.A821@twiddle.net>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from

	bk://are.twiddle.net/tga-2.5

The linux/fb.h fragment re-fixes a 64-bit portability problem.



r~




 drivers/video/tgafb.c |  607 ++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fb.h    |    1 
 include/video/tgafb.h |    1 
 3 files changed, 588 insertions, 21 deletions

through these ChangeSets:

<rth@are.twiddle.net> (03/01/02 1.934)
   [FB] Re-add fb_readq for non-sparc.
   
   This was originally added in rev 1.26.1.2, then dropped 
   during a merge in rev 1.33.  Please be more careful with
   those merges, people.

<rth@are.twiddle.net> (03/01/02 1.932)
   [TGAFB] Implement the fb_copyarea hook.

<rth@are.twiddle.net> (02/12/31 1.911.4.34)
   [TGAFB] Implement the fb_fillrect hook.

