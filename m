Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291372AbSCDEwK>; Sun, 3 Mar 2002 23:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291399AbSCDEvv>; Sun, 3 Mar 2002 23:51:51 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:45042
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291372AbSCDEvl>; Sun, 3 Mar 2002 23:51:41 -0500
Date: Sun, 3 Mar 2002 20:52:37 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "T. A." <tkhoadfdsaf@hotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question on the rmap VM
Message-ID: <20020304045237.GE353@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"T. A." <tkhoadfdsaf@hotmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <OE50LayI4TY7zD5J47O00005d3d@hotmail.com> <E16hWEG-0004IT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16hWEG-0004IT-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 01:40:44PM +0000, Alan Cox wrote:
> >     I have a question on the rmap VM.  What is the swap requierment for it?
> > I remember the previous Rik van Riel VM required twice the amount of
> > swapspace as memory to run effectively as many people were complaining about
> > that.  I read a while ago that the switch in 2.4.10 to the new AA VM fixed
> > that issue.  Will rmap bring back that 2x requirement?  Thanks.
> 
> That issue was fixed before the VM was changed - its actually a seperate
> matter of when the kernel went to the trouble of trying to dig stuff out
> of swap.
> 
> If you have a 2.4.18-ac2 kernel you can also see the worst case swap 
> usage requirement at the current moment in /proc/meminfo as
> "Committed AS" 
> 

Can "Committed AS" be easily ported to mainline or -aa?  IOW, does it have an
effective requirement for rmap?
