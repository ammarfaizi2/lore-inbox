Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTCCKfK>; Mon, 3 Mar 2003 05:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTCCKfK>; Mon, 3 Mar 2003 05:35:10 -0500
Received: from mail.ithnet.com ([217.64.64.8]:43533 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S263039AbTCCKfJ>;
	Mon, 3 Mar 2003 05:35:09 -0500
Date: Mon, 3 Mar 2003 11:45:04 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@redhat.com>
Cc: kimball@serverworks.com, alan@redhat.com, davej@codemonkey.org.uk,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Tighten up serverworks workaround.
Message-Id: <20030303114504.72f47d0e.skraw@ithnet.com>
In-Reply-To: <200302261803.h1QI3BT24020@devserv.devel.redhat.com>
References: <OMEEJAEPHFDBEBPLINBDCELACNAA.kimball@serverworks.com>
	<200302261803.h1QI3BT24020@devserv.devel.redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003 13:03:10 -0500 (EST)
Alan Cox <alan@redhat.com> wrote:

> > How can e help?  Please give me a configuration and how the bug manifests
> > inself.
> 
> OSB4 chipset system, some memory areas marked write combining with the
> processor memory type range registers. A long time ago Dell (I
> think) reported corruption from this and submitted changes to block the
> use of write combining on OSB4. The question has arisen as to whether
> thats a known thing, and if so which release of the chipset fixed it so that
> people can only apply such a restriction to problem cases not all OSB4.
> 
> Alan

While we are at the topic. What exactly is this:

00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-

00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-

00:0f.3 Host bridge: ServerWorks: Unknown device 0225
        Subsystem: ServerWorks: Unknown device 0230  
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

Taken from an Asus TRL-DLS.

-- 
Regards,
Stephan

