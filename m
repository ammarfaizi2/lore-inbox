Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWJLVZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWJLVZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWJLVZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:25:30 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4019 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751010AbWJLVZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:25:30 -0400
Subject: Re: USB performance bug since kernel 2.6.13 (CRITICAL???)
From: Lee Revell <rlrevell@joe-job.com>
To: Open Source <opensource3141@yahoo.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20061012205651.2853.qmail@web58103.mail.re3.yahoo.com>
References: <20061012205651.2853.qmail@web58103.mail.re3.yahoo.com>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 17:26:26 -0400
Message-Id: <1160688386.24931.95.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 13:56 -0700, Open Source wrote:
> Yes, I am pretty sure you are right about the timing.  But it shouldn't be that way.  If it is, then there's a bug.
> 
> I'm fully willing to accept there is something else I should be doing driver-wise, but it shoudn't require recompiling the stock distribution kernels.  Otherwise, Linux is not competitive with Microsoft Windows in this regard!
> 
> I'll try a recompile and report back.  In the meantime, if anyone else has any ideas, please let me know!
> 

Yes, I agree that it would be a bug.  If it turns out to be related to
CONFIG_HZ, ask your distro why they rolled it back from 1000 to 250Hz.

Lee


