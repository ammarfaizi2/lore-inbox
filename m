Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261187AbSI1LHD>; Sat, 28 Sep 2002 07:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261206AbSI1LHD>; Sat, 28 Sep 2002 07:07:03 -0400
Received: from h008.c015.snv.cp.net ([209.228.35.123]:59572 "HELO
	c015.snv.cp.net") by vger.kernel.org with SMTP id <S261187AbSI1LHD>;
	Sat, 28 Sep 2002 07:07:03 -0400
X-Sent: 28 Sep 2002 11:12:22 GMT
Date: Sat, 28 Sep 2002 13:10:00 +0200
To: jbradford@dial.pipex.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel crashes when recording audio
Message-ID: <20020928111000.GA1454@cornils.net>
References: <20020928005611.GB1070@cornils.net> <200209280746.g8S7k1Jj000910@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209280746.g8S7k1Jj000910@darkstar.example.net>
User-Agent: Mutt/1.3.28i
From: Malte Cornils <mcornils@cornils.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Sep 28, 2002 at 08:46:00AM +0100, jbradford@dial.pipex.com wrote:
> > 00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
> > 	Interrupt: pin C routed to IRQ 5
> > 
> > 00:0b.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro (rev dc) (prog-if 00 [VGA])
> > 	Interrupt: pin A routed to IRQ 5
> 
> These two devices share IRQ 5, maybe that is the problem.

No, I tried with all devices on their own interrupt, still gives the same
Oops. Good idea though, but I guess this is one of the rare cases the PCI
spec interrupt sharing actually worked...

-Malte #8-)

BTW: you luckily assumed that anyway, but since I forgot to mention that 
in my first mail: please Cc: me since I'm not subscribed to LKML currently.
