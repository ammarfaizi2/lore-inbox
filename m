Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTCCOfo>; Mon, 3 Mar 2003 09:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbTCCOfo>; Mon, 3 Mar 2003 09:35:44 -0500
Received: from 213.237.116.70.adsl.oebr.worldonline.dk ([213.237.116.70]:39789
	"EHLO thor.jiffies.dk") by vger.kernel.org with ESMTP
	id <S265135AbTCCOfm>; Mon, 3 Mar 2003 09:35:42 -0500
Date: Mon, 3 Mar 2003 15:46:02 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
Message-ID: <20030303144602.GA3602@jiffies.dk>
References: <20030303100515.GA2697@jiffies.dk> <1046698844.5890.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046698844.5890.2.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: Christoffer Hall-Frederiksen <hall@jiffies.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 01:40:44PM +0000, Alan Cox wrote:
|>  Its freezing after setup somewhere. There have been a lot of scsi changes
|>  and not all of them are ones I've checked with aacraid. The osdl guys have
|>  actually done pretty much all the work so far.
|>  
|>  First things to try
|>  
|>  Does it hang with SMP/Pre-empt off
|>  Where does the nmi lockbreaker show it hanging 

Preemt was never on and turning off smp doesn't change anything, the
freeze happens in the same place.

I've tried with UP, APIC-enabled and nmi_watchdog={1,2}, but that
doesn't change anything. Next I'll be throwing kgdb after it.

-- 
	Christoffer
