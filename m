Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265490AbUHFCSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbUHFCSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268078AbUHFCSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:18:33 -0400
Received: from lakermmtao08.cox.net ([68.230.240.31]:24022 "EHLO
	lakermmtao08.cox.net") by vger.kernel.org with ESMTP
	id S265490AbUHFCSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:18:21 -0400
Date: Thu, 5 Aug 2004 17:26:32 -0400
From: Chris Shoemaker <c.shoemaker@cox.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Message-ID: <20040805212632.GB11395@cox.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040804204640.64cd65fc.akpm@osdl.org> <200408050031.21366.gene.heskett@verizon.net> <200408051133.44684.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051133.44684.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 11:33:44AM +0300, Denis Vlasenko wrote:
> 
> You may use cpuburn to test RAM/CPU too.
> 
> Although I have a memory which, when clocked a bit too high,
> pass both memtest86 and cpuburn for extended periods of time,
> yet large compile runs die with sig11 sometimes. Using a tiny
> bit less aggressive clocking helped. :)
> -- 
> vda

Oh yes, now I remember that it was you who recommened cpuburn to me back
in April/May or so.  I also was suspicious that neither memtest86 nor
cpuburn were really stressful enough, but the large-compiles-in-a-loop
weren't any better for me.  I would _love_ to just have some confident
test to say "yep, your hardware is bad, go buy a shiny new box"  :)

I've seen memtest86 actually find bad RAM on a machine before, so I know
it works _sometimes_.  Can anyone say the same for cpuburn?  What does
a failure look like, and were there correlated symptoms like kernel oopses?

-chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
