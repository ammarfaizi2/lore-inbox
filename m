Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbSCCN0A>; Sun, 3 Mar 2002 08:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbSCCNZu>; Sun, 3 Mar 2002 08:25:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30474 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284732AbSCCNZm>; Sun, 3 Mar 2002 08:25:42 -0500
Subject: Re: Question on the rmap VM
To: tkhoadfdsaf@hotmail.com (T. A.)
Date: Sun, 3 Mar 2002 13:40:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <OE50LayI4TY7zD5J47O00005d3d@hotmail.com> from "T. A." at Mar 03, 2002 04:17:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hWEG-0004IT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     I have a question on the rmap VM.  What is the swap requierment for it?
> I remember the previous Rik van Riel VM required twice the amount of
> swapspace as memory to run effectively as many people were complaining about
> that.  I read a while ago that the switch in 2.4.10 to the new AA VM fixed
> that issue.  Will rmap bring back that 2x requirement?  Thanks.

That issue was fixed before the VM was changed - its actually a seperate
matter of when the kernel went to the trouble of trying to dig stuff out
of swap.

If you have a 2.4.18-ac2 kernel you can also see the worst case swap 
usage requirement at the current moment in /proc/meminfo as
"Committed AS" 

Alan
