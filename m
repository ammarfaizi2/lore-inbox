Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbTAGR4o>; Tue, 7 Jan 2003 12:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267530AbTAGR4n>; Tue, 7 Jan 2003 12:56:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50056
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267528AbTAGR4l>; Tue, 7 Jan 2003 12:56:41 -0500
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Grant Grundler <grundler@cup.hp.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030107202755.E559@localhost.park.msu.ru>
References: <20030106215210.GE26790@cup.hp.com>
	 <Pine.LNX.4.44.0301061515530.10086-100000@home.transmeta.com>
	 <20030107001332.GJ26790@cup.hp.com>
	 <1041942820.20658.2.camel@irongate.swansea.linux.org.uk>
	 <20030107202755.E559@localhost.park.msu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041965207.21652.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Jan 2003 18:46:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 17:27, Ivan Kokshaysky wrote:
> I don't think IDE DMA is active at that point. But in either case,
> with the 2-pass approach we should be able to handle 100% of
> problematic hardware.

Audio side too. I don't know about the USB (which may be
active in SMM mode). I can test that tomorrow

