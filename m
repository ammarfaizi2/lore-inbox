Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267166AbSLQWGr>; Tue, 17 Dec 2002 17:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267171AbSLQWGr>; Tue, 17 Dec 2002 17:06:47 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:55706 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267166AbSLQWGq>; Tue, 17 Dec 2002 17:06:46 -0500
Date: Tue, 17 Dec 2002 16:14:41 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'Ducrot Bruno'" <poup@poupinou.org>, <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, <acpi-devel@lists.sourceforge.net>
Subject: RE: [PATCH] S4bios for 2.5.52.
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A5B1@orsmsx119.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0212171611460.21707-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2002, Grover, Andrew wrote:

> > From: Ducrot Bruno [mailto:poup@poupinou.org] 
> > This patch add s4bios support for 2.5.52.

> > echo 4 > /proc/acpi/sleep is for swsusp;
> > echo 4b > /proc/acpi/sleep is for s4bios.
> 
> I still am not clear on why we would want s4bios in 2.5.x, since we have S4.
> Like you said, S4bios is easier to implement, but since Pavel has done much
> of the heavy lifting required for S4 proper, I don't see the need.

Let me counter this, I have to admit that I didn't try the patch yet, but
my laptop does S4 BIOS, and I'd definitely prefer that to swsusp, since
it's much faster and also I somewhat have more faith into S4 BIOS than
swsusp (as in: after resuming, it'll most likely either work or crash, but
not cause any weird kinds of corruption). Since it does not need not much
more to support it than S3, I don't see why you wouldn't want to give
users the option?

--kai


