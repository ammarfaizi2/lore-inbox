Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbTARMJ4>; Sat, 18 Jan 2003 07:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbTARMJ4>; Sat, 18 Jan 2003 07:09:56 -0500
Received: from msg.vodafone.pt ([212.18.167.162]:12700 "EHLO msg.vodafone.pt")
	by vger.kernel.org with ESMTP id <S264673AbTARMJz>;
	Sat, 18 Jan 2003 07:09:55 -0500
Subject: Re: radeonfb almost there.. but not quite! :)
From: "Paulo Andre'" <fscked@netvisao.pt>
To: James Simmons <jsimmons@infradead.org>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>,
       Alessandro Suardi <alessandro.suardi@oracle.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0301171559280.24931-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0301171559280.24931-100000@phoenix.infradead.org>
Content-Type: text/plain
Organization: Corleone Hacking Corp.
Message-Id: <1042892327.437.5.camel@nostromo.orion.int>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Jan 2003 12:18:47 +0000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 12:18:01.0398 (UTC) FILETIME=[A4F61D60:01C2BEEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-17 at 16:01, James Simmons wrote:
> > This is on an IBM Thinkpad A30p with 1600x1200 local display.
> > > radeonfb_pci_register BEGIN
> > > radeonfb: ref_clk=2700, ref_div=60, xclk=16600 from BIOS
> > > radeonfb: probed DDR SGRAM 32768k videoram
> > > radeon_get_moninfo: bios 4 scratch = 1000004
> > > radeonfb: panel ID string: 1600x1200
> > > radeonfb: detected DFP panel size from BIOS: 1600x1200
> > > radeonfb: ATI Radeon M6 LY DDR SGRAM 32 MB
> > > radeonfb: DVI port LCD monitor connected
> > > radeonfb: CRT port no monitor connected
> > > radeonfb_pci_register END
> > 
> > Do you have CONFIG_DRM=y ?
> > 
> > I'd _really_ like to have some feedback from James Simmons on this.
> 
> I'm here. I see the radeon fbdev driver is detected and it works :-) The 
> issue is a X conflict. Does disabling CONFIG_DRM work? 
> 
Doesn't solve my problem. To tell you the truth I already use CONFIG_DRM=n
for a while now considering it keeps me from switching from console to X
(either in 2.4 or 2.5). It just locks hard if I do so.

Anyway, it can't be an X conflict, as far as I'm concerned because the
problems happen on the framebuffer console, not X related. Please refer
to my first email, which I sent to you directly and to this list, for
details.

And thanks for your reply.

	../Paulo

