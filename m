Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVGQCa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVGQCa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 22:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVGQCa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 22:30:28 -0400
Received: from [202.136.32.45] ([202.136.32.45]:52622 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261753AbVGQCa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 22:30:26 -0400
From: Grant Coady <lkml@dodo.com.au>
To: rct@gherkin.frus.com (Bob Tracy)
Cc: linux@dominikbrodowski.net, linix-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 vs. /sbin/cardmgr
Date: Sun, 17 Jul 2005 12:30:07 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <ijgjd1loteavmfe5h466ou4ie73tefe5bf@4ax.com>
References: <20050716163645.8FD8DDBA1@gherkin.frus.com>
In-Reply-To: <20050716163645.8FD8DDBA1@gherkin.frus.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2005 11:36:45 -0500 (CDT), rct@gherkin.frus.com (Bob Tracy) wrote:

>rct wrote:
>> Dominik Brodowski wrote:
>> > On Sun, Jul 10, 2005 at 03:37:22PM -0500, Bob Tracy wrote:
>> > > Dominik Brodowski wrote:
>> > > > On Sat, Jul 09, 2005 at 12:12:17AM -0500, Bob Tracy wrote:
>> > > > > (/sbin/cardmgr chewing up lots of CPU cycles with 2.6.12 kernel)
>> > > > 
>> > > > Please post the output of "lspci" and "lsmod" as I'd like to know which
>> > > > kind of PCMCIA bridge is in your notebook.
>> > 
>> > OK, it's a plain TI1225. Could you try whether the bug is still existent in
>> > 2.6.13-rc3, please?
>> 
>> 2.6.13-rc3 works fine here.  The "cardmgr" process is no longer chewing
>> up lots of CPU time, and otherwise seems to be working correctly.  Thanks!
>
>I spoke too soon :-(.  The first boot on 2.6.13-rc3 was fine.  Every
>boot since then has reflected no change relative to the 2.6.12 behavior.
>The "cardmgr" process racks up CPU time almost as fast as time
>elapses: it's at the top of the "top" list.

I turned off cardmgr for 2.6, CardBus works without it on slackware 
'cos pciutils is patched to provide a helper, what is 'correct' way 
to test this?  

Toshiba laptop with ToPIC100 bridge, currently not working for 
PCCard 16-bit things because I turned off cardmgr.  CardBus NIC 
works in 2.4 + 2.6 series.

--Grant.


