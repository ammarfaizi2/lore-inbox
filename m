Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSGBTjT>; Tue, 2 Jul 2002 15:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSGBTjS>; Tue, 2 Jul 2002 15:39:18 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:60688
	"EHLO muru.com") by vger.kernel.org with ESMTP id <S316883AbSGBTjS>;
	Tue, 2 Jul 2002 15:39:18 -0400
Date: Tue, 2 Jul 2002 12:41:44 -0700
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amd-smp-idle module avail for testing max 90 W power savings
Message-ID: <20020702194144.GB25135@atomide.com>
References: <20020702191454.GA25135@atomide.com> <20020702212759.47587b23.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702212759.47587b23.sebastian.droege@gmx.de>
User-Agent: Mutt/1.3.28i
X-Mailer: Mutt http://www.mutt.org/
X-URL: http://www.muru.com/ http://www.atomide.com
X-Accept-Language: fi en
X-Location: USA, California, San Francisco
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Droege <sebastian.droege@gmx.de> [020702 12:29]:
> On Tue, 2 Jul 2002 12:14:54 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > Amd-smp-idle enables the power savings mode like VCool and LVCool, but
> > amd-smp-idle uses the Linux PCI features, and supports currently SMP
> > only. So far I've squeezed out maximum 90 Watt power savings out of my
> > system :)
> > 
> > http://www.muru.com/linux/amd-smp-idle/
>
> Is it possible to do something similar for AMD-751 or VIA-686a (or other UP Athlon chipsets)?

Yes, you could use LVCool program, or merge the LVCool functionality to
amd-smp-idle. I added place holders for enabling other chips.

Just add functions for enabling north and southbridge, and then fill in 
the idle function. I kind of thought of modifying LVCool, but it was not 
using the Linux PCI API, and was not really suitable for SMP systems.

LVCool is at:

http://mpet.freeservers.com/LVCool.html

Tony
