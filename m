Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbUAAPpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 10:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUAAPpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 10:45:20 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:25098 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264433AbUAAPpR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 10:45:17 -0500
Date: Thu, 1 Jan 2004 16:56:52 +0100
To: Anders Skovsted Buch <abuch@imf.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: System lockup when playing chess
Message-ID: <20040101155652.GB27217@hh.idb.hist.no>
References: <Pine.HPP.3.95.1031231170644.6451A-100000@aragorn.imf.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.HPP.3.95.1031231170644.6451A-100000@aragorn.imf.au.dk>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 02:31:58PM +0100, Anders Skovsted Buch wrote:
> Hello,
> 
> I am experiencing consistent lockups of the linux kernel when I play chess
> with crafty.  What happens is that while the chess engine is running,
> suddenly the whole system will freeze, and the only think I can get to
> work is the reboot button.  I have tried to put the computer in text-mode
> (telinit 3) and run the chess program (with gui) from another computer on
> my LAN, to see if any oops-output would show up, but there is nothing.
> 
> My system runs Redhat 7.2 and is uptodate with patches (so I'm running
> kernel version 2.4.20-24.7 #1, athlon version).  The chess program is
> Crafty 17.9.  The processor is "AMD Athlon(tm) 4 Processor".
> /var/log/messages shows nothing of interest.
> 
> I wonder if this scarse information is good for anything.  And in any
> case, thanks for all your great work which I benefit from every day!!
> 
Could this be a simple overheating problem?
Chess programs are cpu intensive, and so the cpu gets hot.
Perhaps there is insufficient cooling. the cooling may be
enough for non-cpu intensive stuff like email, web, and so on.
what happens if you run a big compile or a long-lasting
cpu benchmark?  Those things also cause heat.

Helge Hafting
