Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbTFSFsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 01:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbTFSFsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 01:48:20 -0400
Received: from angband.namesys.com ([212.16.7.85]:39302 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S265111AbTFSFsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 01:48:19 -0400
Date: Thu, 19 Jun 2003 10:02:17 +0400
From: Oleg Drokin <green@namesys.com>
To: Olivier NICOLAS <olivn@trollprod.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.7x: processes in D state
Message-ID: <20030619060217.GA23774@namesys.com>
References: <3EF0CBCB.4010202@trollprod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF0CBCB.4010202@trollprod.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jun 18, 2003 at 10:30:03PM +0200, Olivier NICOLAS wrote:

> AltSysRq T ....
> .....
> konqueror     D 00000001 4244652160  1965   1943                     (NOTLB)
> Call Trace:
>  [<c011c3aa>] default_wake_function+0x2a/0x30
>  [<c011cb5e>] sleep_on+0x6e/0x130
>  [<c011c380>] default_wake_function+0x0/0x30
>  [<c01e6768>] do_journal_begin_r+0x88/0x2a0

So they want to open the journal, but it is held by somebody else already.
Can you please look include stacktraces for all other processes that have
reiserfs bits in the trace and show those traces too? Or just mail me full sysrq-T outputs
at the time of such a happinings.

Thank you.

Bye,
    Oleg
