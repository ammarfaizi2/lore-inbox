Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751914AbWICCaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWICCaa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 22:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbWICCaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 22:30:30 -0400
Received: from mxsf21.cluster1.charter.net ([209.225.28.221]:55715 "EHLO
	mxsf21.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751914AbWICCaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 22:30:30 -0400
X-IronPort-AV: i="4.08,203,1154923200"; 
   d="scan'208"; a="827234412:sNHT20419064"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17658.15935.903687.325991@smtp.charter.net>
Date: Sat, 2 Sep 2006 22:30:23 -0400
From: "John Stoffel" <john@stoffel.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "John Stoffel" <john@stoffel.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc5-mm1, make oldconfig from 2.6.18-rc5 destroys LVM
In-Reply-To: <20060902184054.5db9fe00.akpm@osdl.org>
References: <17658.9856.132429.196116@smtp.charter.net>
	<20060902184054.5db9fe00.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

>> And I'd really suggest that it NOT be this silly name BLOCK, something
>> more meaningful, like USE_BLOCK_DEVICES or something equally useful to
>> parse.

Andrew> mm...  I think CONFIG_BLOCK is a reasonable compromise between
Andrew> the needs for brevity and understandability.

Well, maybe the hotfix patch converts all the uses of 'if BLOCK' to
'if CONFIG_BLOCK', but I still think that 'if USE_BLOCK_DEVS' would be
more clear.  It's not like it should be all *that* used outside of
config stuff.

Oh well, thanks for your reply, now I can test 2.6.18-rc5-mm1 and see
if my IRQ problem is really there or not.

John

-- 
VGER BF report: U 0.5
