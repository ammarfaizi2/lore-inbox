Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTEVSu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTEVSu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:50:27 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:38646 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263126AbTEVSu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:50:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16077.7935.493781.786686@gargle.gargle.HOWL>
Date: Thu, 22 May 2003 21:03:27 +0200
From: mikpe@csd.uu.se
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: arch/i386/kernel/mpparse.c warning fixes
In-Reply-To: <20030522185921.GW8978@holomorphy.com>
References: <20030522155320.GP29926@holomorphy.com>
	<16076.62927.525714.113342@gargle.gargle.HOWL>
	<20030522162305.GT8978@holomorphy.com>
	<16077.5909.155004.502440@gargle.gargle.HOWL>
	<20030522183608.GV8978@holomorphy.com>
	<16077.7101.339611.256918@gargle.gargle.HOWL>
	<20030522185921.GW8978@holomorphy.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
 > On Thu, May 22, 2003 at 08:49:33PM +0200, mikpe@csd.uu.se wrote:
 > > Ah, so it's a workaround to silence a compiler warning on char > 256.
 > > Frankly, I'd rather see a cast there in this case. I.e.,
 > > 	 (unsigned int)m->mpc_apicid >= MAX_APICS
 > > or something like that, with a suitable comment.
 > 
 > Already tried it. It does not suffice to silence the compiler.

Ok, I give up. The stupid POS compiler forces the ugly rewrite...
