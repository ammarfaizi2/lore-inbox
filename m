Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbTBJP2s>; Mon, 10 Feb 2003 10:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbTBJP2s>; Mon, 10 Feb 2003 10:28:48 -0500
Received: from smtp04.iprimus.com.au ([210.50.76.52]:31497 "EHLO
	smtp04.iprimus.com.au") by vger.kernel.org with ESMTP
	id <S264631AbTBJP2r>; Mon, 10 Feb 2003 10:28:47 -0500
Message-ID: <001501c2d11a$3ad9c3a0$59951ad3@windows>
From: "James Buchanan" <jamesbuch@iprimus.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: SMP-Linux
Date: Tue, 11 Feb 2003 02:36:48 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-OriginalArrivalTime: 10 Feb 2003 15:38:31.0087 (UTC) FILETIME=[76B73BF0:01C2D11A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

I am new to this so please forgive this post if it seems stupid.

Is it possible to design a SMP-Linux kernel with architecture
independent SMP support, for example, like the VFS provides an
interface to specific filesystems, the "VSMP" can provide an
architecture independent way to support SMP?  There can be a function
that does the spinlock stuff and underneath is a machine dependent
implementation (this is already done for x86, what about other MP
capable architectures?), and same for the scheduler.  Lots of other
stuff like TLB issues and so on would have to be taken care of as
well.  I'm no expert on SMP so I don't really know if a "virtual" SMP
support is possible in the way I am describing it.

Is this an interesting idea to anyone?  I expect it has been thought
of before, but maybe it needs a hell of a lot of research to even
begin thinking about it seriously.  If anyone is interesting in really
thrashing this out off list (or on list, but is this considered bad
netiquette?), please mail me.  I am very interested in discussing this
in horrid detail :-)

When I buy my SMP system, I plan to hack in the first stages of such
"VSMP" support if it's feasible.

Again, I don't really know what I'm doing so please go easy on me :-)
I am still in the early stages of soaking up the stuff in the Intel
CPU programming manuals.

Thanks!
James

