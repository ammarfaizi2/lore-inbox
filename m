Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267375AbTA1QyF>; Tue, 28 Jan 2003 11:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267377AbTA1QyF>; Tue, 28 Jan 2003 11:54:05 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:62409 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S267375AbTA1QyE>; Tue, 28 Jan 2003 11:54:04 -0500
Date: Tue, 28 Jan 2003 09:03:12 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Christian Zander <zander@minion.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030128170312.GT20972@ca-server1.us.oracle.com>
References: <20030127221523.GP20972@ca-server1.us.oracle.com> <20030127175917.GO20972@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301271208580.18686-100000@chaos.physics.uiowa.edu> <20656.1043768637@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20656.1043768637@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 03:43:57PM +0000, David Woodhouse wrote:
> Er, if vermagic.o needed to change, then your module build was broken
> already and wouldn't have worked against the precompiled kernel. That's 

	If you've precompiled the kernel, you have a full kernel built
tree.  If you haven't, then vermagic.o isn't there.  Plus, modversions
requires the objects according to kai.
	In 2.4, a "make config" and "make dep" pretty much does what is
needed.  The kernel is ready to be used by external modules.

Joel

-- 

"You can get more with a kind word and a gun than you can with
 a kind word alone."
         - Al Capone

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
