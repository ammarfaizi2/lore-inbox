Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275565AbTHNU4W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275576AbTHNU4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:56:22 -0400
Received: from mail13.speakeasy.net ([216.254.0.213]:32426 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S275565AbTHNU4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:56:21 -0400
Date: Thu, 14 Aug 2003 13:56:17 -0700
Message-Id: <200308142056.h7EKuH724585@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Matt Wilson <msw@redhat.com>,
       <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] revert zap_other_threads breakage, disallow CLONE_THREAD
 without CLONE_DETACHED
In-Reply-To: Linus Torvalds's message of  Thursday, 14 August 2003 10:32:35 -0700 <Pine.LNX.4.44.0308141023480.8148-100000@home.osdl.org>
X-Fcc: ~/Mail/linus
X-Windows: some voids are better left unfilled.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which means that they are logically not separate bits any more, and we
> should just get rid of CLONE_DETACHED altogether, and use CLONE_THREAD in
> all cases where it is tested for.

That is certainly fine by me.


Thanks,
Roland
