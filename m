Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUHSHRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUHSHRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUHSHRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:17:51 -0400
Received: from colino.net ([82.228.82.76]:2546 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262932AbUHSHRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:17:17 -0400
Date: Thu, 19 Aug 2004 09:16:55 +0200
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: Kurt Garloff <garloff@suse.de>
Subject: Re: [PATCH] bio_uncopy_user mem leak
Message-ID: <20040819091655.1f1b06e3@pirandello>
X-Mailer: Sylpheed-Claws 0.9.12cvs65.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040817155918.GA5312@tpkurt.garloff.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> This bug was triggered by writing audio CDs (but not on data 
> CDs), as the audio frames are not aligned well (2352 bytes),
> so the user pages don't just get mapped.

This patch has been reported by a few people as fixing the leak problem,
but the produced audio CDs are corrupt.
(I didn't try it myself, already trashed 2 CDs ;-))

see http://kerneltrap.org/node/view/3659 for example

Thanks for your work,
-- 
Colin
