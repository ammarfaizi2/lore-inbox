Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275719AbRJFUwB>; Sat, 6 Oct 2001 16:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275732AbRJFUvm>; Sat, 6 Oct 2001 16:51:42 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:1411 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S275719AbRJFUve>;
	Sat, 6 Oct 2001 16:51:34 -0400
Date: Sat, 6 Oct 2001 22:52:05 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Patrick Allaire <pallaire@gameloft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bad memory ... reservation !
In-Reply-To: <9A1957CB9FC45A4FA6F35961093ABB8404C0E8FC@srvmail-mtl.ubisoft.qc.ca>
Message-ID: <Pine.LNX.4.21.0110062251290.14152-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2001, Patrick Allaire wrote:

> 
> Hi all,
> 
> I am currently working on a small embedded gaming box wich run linux ... but
> I have a small problem. We have a demo to give on tuesday and the box isnt
> booting pass the kernel, we have found for sure that this is due to an
> hardware bug of the second bank of memory. We have 16MB of memory in the box
> ... is there a way to reserve the 4-8MB so linux des not try to go there.
> Since this is an hardware bug, we will have to redo our silicons, but they
> wont be ready for this week...
> 
> what the best way to tell linux to jump over this bad memory ? command line
> ? hack in the mm ?
> 
> I am using kernel 2.4.9.

You might be able to use the BadRAM patches from
http://rick.vanrein.org/linux/badram/

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

