Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbUKFWIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbUKFWIc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 17:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbUKFWIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 17:08:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50180 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261482AbUKFWI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 17:08:28 -0500
Date: Sat, 6 Nov 2004 23:07:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bloat
Message-ID: <20041106220753.GQ1295@stusta.de>
References: <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl> <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041106120716.GA9144@pclin040.win.tue.nl> <Pine.LNX.4.58.0411060922260.2223@ppc970.osdl.org> <20041106193605.GL1295@stusta.de> <20041106214147.GA9663@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106214147.GA9663@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 10:41:47PM +0100, Andries Brouwer wrote:
> On Sat, Nov 06, 2004 at 08:36:08PM +0100, Adrian Bunk wrote:
> 
> > It's even harder because some subsystem maintainers refuse to remove 
> > unused global functions that might be used at some point far in the 
> > future or that even are never intended for in-kernel usage...
> 
> I have one or two unused functions inside #if 0 in sddr09.c.
> Finding out the proper hardware details was nontrivial,
> it would be a pity to throw the knowledge away.
> But of course there is never a reason to have an unused function
> appear in the binary. It is only source bloat.

No disagreement on this issue.

But unused global functions that are even EXPORT_SYMBOL'ed like in the 
ACPI and FireWire cases are not only source bloat...

> Andries

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

