Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270463AbTGNAGF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 20:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270461AbTGNAGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 20:06:05 -0400
Received: from webmail.hamiltonfunding.la ([12.162.17.40]:46225 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S270459AbTGNAGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 20:06:02 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: alan@storlinksemi.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com>
	<20030713004818.4f1895be.davem@redhat.com>
	<52u19qwg53.fsf@topspin.com>
	<20030713160200.571716cf.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 13 Jul 2003 17:20:41 -0700
In-Reply-To: <20030713160200.571716cf.davem@redhat.com>
Message-ID: <52llv2vu06.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Jul 2003 00:20:44.0218 (UTC) FILETIME=[C3EB59A0:01C3499D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> I didn't say I agree with all of Moguls ideas, just his
    David> anti-TOE arguments.  For example, I also think RDMA sucks
    David> too yet he thinks it's a good iea.

Sure, he talks about some weaknesses of TOE, but his conclusion is
that the time has come for OS developers to start working on TCP
offload (for storage).

    David> You obviously don't understand my ideas if you think that
    David> it matters whether there is some relationship between the
    David> MTU and the system page size necessary for the scheme to
    David> work.

I was just quoting part of Mogul's paper that seemed to directly
contradict your original post.  I also said it would be great to see
NIC hardware with support for flow classification.

Look, I pretty much agree with you about TOE hardware.  Every chip
I've seen either requires a bunch of dedicated expensive memory
(including a giant CAM) or is just firmware running on a
low-performance embedded CPU.  But I also think Mogul is right: iSCSI
HBAs are going to force OS designers to deal with TCP offload.

My whole point was just that it doesn't make much sense to dismiss the
whole idea by saying "TOE is evil" and then cite as support a paper
that explains why TOEs now make sense and need to be supported.

 - Roland
