Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268460AbTCCIwS>; Mon, 3 Mar 2003 03:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268463AbTCCIwS>; Mon, 3 Mar 2003 03:52:18 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:46283 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268460AbTCCIwR>; Mon, 3 Mar 2003 03:52:17 -0500
Date: Mon, 3 Mar 2003 04:03:40 -0500 (EST)
From: "Mike A. Harris" <mharris@redhat.com>
X-X-Sender: mharris@devel.capslock.lan
To: Alan Cox <alan@redhat.com>
cc: Kimball Brown <kimball@serverworks.com>, <davej@codemonkey.org.uk>,
       <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Tighten up serverworks workaround.
In-Reply-To: <200302261803.h1QI3BT24020@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0303030357580.1032-100000@devel.capslock.lan>
Organization: Red Hat Inc.
X-Unexpected-Header: The Spanish Inquisition
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Alan Cox wrote:

>> How can e help?  Please give me a configuration and how the bug manifests
>> inself.
>
>OSB4 chipset system, some memory areas marked write combining with the
>processor memory type range registers. A long time ago Dell (I
>think) reported corruption from this and submitted changes to block the
>use of write combining on OSB4. The question has arisen as to whether
>thats a known thing, and if so which release of the chipset fixed it so that
>people can only apply such a restriction to problem cases not all OSB4.

I've got 2 OSB4 machines here, one a Tyan HEsl 2567 board. MTRRs 
have been disabled on this board for a couple years now with 
every kernel release, which I'm told is due to the MTRR problem 
described in this thread.

00:00.1 PCI bridge: ServerWorks CNB20LE (rev 01)

Kimball, we chatted before about AGP on this board and a few
other issues, but I don't know if we discussed the MTRR issue.  
Could you confirm this problem?  If the problem is anything
workaroundable, it would be nice to have MTRRs working on this
box sometime as video is quite slow.  I'm willing to test any 
potential workarounds if something creeps up.

TIA



-- 
Mike A. Harris     ftp://people.redhat.com/mharris
OS Systems Engineer - XFree86 maintainer - Red Hat

