Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUIK7>; Wed, 21 Feb 2001 03:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBUIKu>; Wed, 21 Feb 2001 03:10:50 -0500
Received: from mail1.svr.pol.co.uk ([195.92.193.18]:27912 "EHLO
	mail1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S129051AbRBUIKj>; Wed, 21 Feb 2001 03:10:39 -0500
Message-ID: <3A9377FA.90508@agelectronics.co.uk>
Date: Wed, 21 Feb 2001 08:10:34 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010112
X-Accept-Language: en
MIME-Version: 1.0
To: Josh Fryman <fryman@cc.gatech.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: query: IP over PCI?
In-Reply-To: <3A92CD06.F19F7C4B@cc.gatech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Fryman wrote:


> there have been many references in the past (notably in the beowulf
> community) about TCP/IP over PCI -- that was way back with kernel
> 2.2.9 and thereabouts (1999).  at that time, there were some patches
> available to implement this...

There are four versions of this that I know of. They come from 
MontaVista, LynuxWorks, Ziatech, and myself. Mine is based on code 
originally written for ARM by Mark van Doesburg, and ported to PowerPC 
by myself. This is probably what you know from the Strongarm Beowulf 
project. I made quite large changes, which haven't been completely 
ported back to ARM. I also added a console over PCI, to avoid the need 
for a serial cable to each plug-in card. This code is available as a 
patch for 2.2 kernels at:

ftp://ftp.agelectronics.co.uk/pub/pcimsg-patch-20001201.gz

- Adrian Cox

