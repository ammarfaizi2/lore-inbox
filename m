Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbSLQWQ2>; Tue, 17 Dec 2002 17:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbSLQWQ2>; Tue, 17 Dec 2002 17:16:28 -0500
Received: from fmr02.intel.com ([192.55.52.25]:965 "EHLO caduceus.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267180AbSLQWQ1>;
	Tue, 17 Dec 2002 17:16:27 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A5B6@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Kai Germaschewski'" <kai@tp1.ruhr-uni-bochum.de>
Cc: "'Ducrot Bruno'" <poup@poupinou.org>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>, acpi-devel@lists.sourceforge.net
Subject: RE: [PATCH] S4bios for 2.5.52.
Date: Tue, 17 Dec 2002 14:24:23 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kai Germaschewski [mailto:kai@tp1.ruhr-uni-bochum.de] 
> > I still am not clear on why we would want s4bios in 2.5.x, 
> since we have S4.
> > Like you said, S4bios is easier to implement, but since 
> Pavel has done much
> > of the heavy lifting required for S4 proper, I don't see the need.
> 
> Let me counter this, I have to admit that I didn't try the 
> patch yet, but
> my laptop does S4 BIOS, and I'd definitely prefer that to 
> swsusp, since
> it's much faster and also I somewhat have more faith into S4 BIOS than
> swsusp (as in: after resuming, it'll most likely either work 
> or crash, but
> not cause any weird kinds of corruption). Since it does not 
> need not much
> more to support it than S3, I don't see why you wouldn't want to give
> users the option?

Ok that's reasonable.

My belief is that S4bios is a stopgap measure until S4 gets better. That
said, I think you are right - it should go in for now, and then at some
point in the future someone will say, "S4bios?? who needs *that* anymore??"
and it will get pulled out. ;-)

So I'll look to merge it, unless someone upstream beats me to it.

Regards -- Andy
