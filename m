Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267608AbTACRxn>; Fri, 3 Jan 2003 12:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267611AbTACRxn>; Fri, 3 Jan 2003 12:53:43 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:32468 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267608AbTACRxm>;
	Fri, 3 Jan 2003 12:53:42 -0500
Date: Fri, 3 Jan 2003 18:00:08 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Richard Baverstock <beaver@gto.net>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AGPGART for VIA vt8235, kernel 2.4.21-pre2
Message-ID: <20030103180008.GB10327@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Richard Baverstock <beaver@gto.net>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <20030102145346.27a21ed9.beaver@gto.net> <20030103171617.B4502@ucw.cz> <20030103122216.39cedd3f.beaver@gto.net> <20030103174323.GA10327@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030103174323.GA10327@codemonkey.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 05:43:23PM +0000, Dave Jones wrote:
 > 
 > In fact, P4X333 defines a chipset rather than a chip.
 > According to ..
 > http://www.viatech.com/en/apollo/p4x333.jsp and
 > http://www.viatech.com/en/apollo/p4x400.jsp ,
 > Just to confirm, device 3168 is the host bridge in lspci output right?
 > And this does all work when you run a DRI application ?

Actually, the P4X400 won't work in current situations.
I'll bet if you put an AGPx8 card in there, it'll do the same
"change into AGP3.0 mode" trick that the KT400 does.
I'll move onto that after I finish up the KT400 GART driver.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
