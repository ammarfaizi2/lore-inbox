Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267547AbTAQPwZ>; Fri, 17 Jan 2003 10:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267546AbTAQPwZ>; Fri, 17 Jan 2003 10:52:25 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:8972 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267547AbTAQPwY>; Fri, 17 Jan 2003 10:52:24 -0500
Date: Fri, 17 Jan 2003 16:01:19 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: "Paulo Andre'" <fscked@netvisao.pt>
cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>,
       Alessandro Suardi <alessandro.suardi@oracle.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb almost there.. but not quite! :)
In-Reply-To: <1042817507.251.4.camel@nostromo.orion.int>
Message-ID: <Pine.LNX.4.44.0301171559280.24931-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This is on an IBM Thinkpad A30p with 1600x1200 local display.
> > radeonfb_pci_register BEGIN
> > radeonfb: ref_clk=2700, ref_div=60, xclk=16600 from BIOS
> > radeonfb: probed DDR SGRAM 32768k videoram
> > radeon_get_moninfo: bios 4 scratch = 1000004
> > radeonfb: panel ID string: 1600x1200
> > radeonfb: detected DFP panel size from BIOS: 1600x1200
> > radeonfb: ATI Radeon M6 LY DDR SGRAM 32 MB
> > radeonfb: DVI port LCD monitor connected
> > radeonfb: CRT port no monitor connected
> > radeonfb_pci_register END
> 
> Do you have CONFIG_DRM=y ?
> 
> I'd _really_ like to have some feedback from James Simmons on this.

I'm here. I see the radeon fbdev driver is detected and it works :-) The 
issue is a X conflict. Does disabling CONFIG_DRM work? 

