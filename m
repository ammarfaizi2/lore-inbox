Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUAVLiK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 06:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266241AbUAVLiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 06:38:10 -0500
Received: from gaia.ailab.ch ([130.60.75.60]:43147 "EHLO gaia.ailab.ch")
	by vger.kernel.org with ESMTP id S266240AbUAVLiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 06:38:06 -0500
Subject: Re: Linux-2.6.1-mm4/5 dies booting on an Athlon64
From: Hanspeter Kunz <hkunz@ifi.unizh.ch>
To: linux-kernel@vger.kernel.org
In-Reply-To: <400FAA7D.1010807@freemail.hu>
References: <400FAA7D.1010807@freemail.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1074771664.2638.49.camel@septumania>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jan 2004 12:41:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an idea: I had similar problems in 2.6.1-mm4.
I had to disable PNP bios support.

cheers,
Hp.

On Thu, 2004-01-22 at 11:48, Boszormenyi Zoltan wrote:
> Hi,
> 
> > Boszormenyi Zoltan writes:
> >  > Hi,
> >  > 
> >  > mainboard is MSI K8T Neo, Athlon64 3200+.
> >  > It does not boot successfully without the "nolapic"
> >  > option. "noapic" does not make any difference, "nolapic" does.
> >  > Kernel is compiled on a 32bit Fedora,
> >  > K7/Athlon and Hammer/Opteron/Athlon64
> >  > are selected under CPU support.
> > 
> > 1. "does not boot successfully" is extremely vague.
> >    Please supply a boot log or decoded kernel oops.
> 
> Uncompressing kernel... and then nothing. Even the screen is emptied,
> cursor blinks in column 0 of line approx. 8, at about 1/3 of the screen.
> 
> > 2. Does this also occur with 2.6.1 or 2.6.2-rc1?
> >    If so, what was the last standard 2.6 kernel that worked?
> > 3. Does 2.4.25-pre6 work?
> 
> I will try these. FC1 2.4.22-2149 definitely works.
> 
> > 4. Try a minimal .config w/o any non-essential features.
> >    (Where non-essential mean anything not needed to boot
> >    and get to a login prompt.)
> 
> OK.
-- 
Hanspeter Kunz
Artificial Intelligence Lab
Dept. of Information Technology
University of Zurich
+41 1 635 43 06 work
+41 1 635 68 09 fax
www.ifi.unizh.ch/~hkunz

