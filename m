Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTK3SuM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 13:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTK3SuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 13:50:12 -0500
Received: from holomorphy.com ([199.26.172.102]:29127 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262767AbTK3SuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 13:50:09 -0500
Date: Sun, 30 Nov 2003 10:50:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.6.0-test5-bk3-17
Message-ID: <20031130185005.GL8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20031128041558.GW19856@holomorphy.com> <20031128072148.GY8039@holomorphy.com> <20031130164301.GK8039@holomorphy.com> <Pine.LNX.4.58.0311301321100.31421@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311301321100.31421@montezuma.fsmlabs.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 01:46:24PM -0500, Zwane Mwaikambo wrote:
> Brilliant!
> Linux arusha.mastecende.com 2.6.0-test11-pgcl #4 SMP Sun Nov 30 13:30:51 EST 2003 i686 i686 i386 GNU/Linux
> tcsh          S C0155C8D     0  1132   1131                     (NOTLB)
> def85e60 00000086 def8b29c c0155c8d def85e44 def85e9c c060b940 c013010f
>        0001c1ec 00000000 c1143640 00008734 ff21d58e 00000019 dea41fd0 0000000e
>        fff24fc0 00000008 7fffffff c1657d7c de7f9000 c0131035 dc21bfcc c1119338
> Call Trace:
[...]
>  [<c0121830>] default_wake_function+0x0/0x20
>  [<c032dfc1>] set_termios+0x111/0x180
>  [<c0121830>] default_wake_function+0x0/0x20
>  [<c0326c3b>] tty_read+0x15b/0x1a0
>  [<c0326ae0>] tty_read+0x0/0x1a0
>  [<c0326ae0>] tty_read+0x0/0x1a0
>  [<c016ac9c>] vfs_read+0xac/0xf0
>  [<c016aead>] sys_read+0x2d/0x50
>  [<c0109719>] sysenter_past_esp+0x52/0x79

I'll call this pgcl-2.6.0-test11-6, then.

-- wli
