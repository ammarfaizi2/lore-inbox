Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbTA3RQt>; Thu, 30 Jan 2003 12:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbTA3RQt>; Thu, 30 Jan 2003 12:16:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22664
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267564AbTA3RQs>; Thu, 30 Jan 2003 12:16:48 -0500
Subject: Re: any brand recomendation for a linux laptop ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hirling Endre <endre@interware.hu>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1043944207.4912.6.camel@dusk.interware.hu>
References: <200301161100.45552.Nicolas.Turro@sophia.inria.fr>
	 <20030116113825.GB21239@codemonkey.org.uk>  <3E36A91F.8F1168DB@cicese.mx>
	 <1043944207.4912.6.camel@dusk.interware.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043950856.31674.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 30 Jan 2003 18:20:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 16:30, Hirling Endre wrote:
> On Tue, 2003-01-28 at 17:00, Serguei Miridonov wrote:
> > I'm writing this in Compaq Presario 900Z which seems to be similar to your Evo
> > 1015v. After installing RedHat 7.3 with nomce, nopci, etc. I've disabled kudzu and
> > then compiled 2.4.20+ac2+acpi-20021212-2.4.20 with sound and IDE fixes. Now I have
> > UDMA IDE, sound, and 802.11b with prism card (actually I'm writing this at home on
> 
> What IDE controller is in the 900z? I have a fujitsu notebook with the
> igp320m chipset and ali southbridge and 2.5 can't do udma. 2.4 can but
> crashes often.

Its an ALI 1535 southbridge with built in IDE DMA support. The 900Z basically 
requires you run 2.4.21pre3-ac5, probably the ACPI patches on top of that
and also pcmcia excludes correctly configured to avoid 0x380-0x3ff

In paticular you can boot with "nomce" but if you do that and don't deal with
the real problems may get some nasty suprises

