Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbUK0Pna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbUK0Pna (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 10:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUK0Pna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 10:43:30 -0500
Received: from mail.linicks.net ([217.204.244.146]:24836 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261235AbUK0Pm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 10:42:29 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.28 -> ch..ch...changes....
Date: Sat, 27 Nov 2004 15:42:27 +0000
User-Agent: KMail/1.7
References: <Pine.LNX.4.44.0411241744210.5172-100000@localhost.localdomain> <200411241957.14527.nick@linicks.net> <877jo8u8q1.fsf@amaterasu.srvr.nix>
In-Reply-To: <877jo8u8q1.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411271542.27896.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 November 2004 11:53, Nix wrote:
> On 24 Nov 2004, Nick Warne mused:
> > Normally memory slowly fills up, perhaps using swap for a bit under these
> > circumstances - but looking afterwards:
>
> This is a feature, not a bug. Free memory is wasted memory (although
> some has to be kept free for drivers that need GFP_ATOMIC allocations:
> i.e. `memory *now* dammit *now*'.
>
> > root@linuxamd:~# free
> >              total       used       free     shared    buffers     cached
> > Mem:       1292348     520012     772336          0      38596     327304
> > -/+ buffers/cache:     154112    1138236
> > Swap:      1959888          0    1959888
>
> The only thing I can think of that causes this is something very
> memory-hungry that's just been killed, releasing a pile of pages back to
> the system.
>
> > But whatever, I am impressed indeed - somethings changed for the good!!!
>
> I see no signs of such a change on my 2.4.28 boxes:

~snip~

Ummm.  I do, though.  Maybe the cause is I am getting more experienced, and 
building kernels now, I _do_ the right things.  But for some reason I do find 
2.4.28 a lot more responsive to memory usage - I really do.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
