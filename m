Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281416AbRKMHtr>; Tue, 13 Nov 2001 02:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281548AbRKMHtg>; Tue, 13 Nov 2001 02:49:36 -0500
Received: from sunfish.linuxis.net ([64.71.162.66]:4002 "HELO
	sunfish.linuxis.net") by vger.kernel.org with SMTP
	id <S281416AbRKMHtW>; Tue, 13 Nov 2001 02:49:22 -0500
From: "Adam McKenna" <adam-dated-1006069566.ee3370@flounder.net>
Date: Mon, 12 Nov 2001 23:46:04 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: DMA problem (?) w/ 2.4.6-xfs and ServerWorks OSB4 Chipset
Message-ID: <20011112234604.C29675@flounder.net>
In-Reply-To: <20010724182512.B4614@flounder.net> <E15POk0-00020K-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15POk0-00020K-00@the-village.bc.nu>
User-Agent: Mutt/1.3.21i
Mail-Copies-To: never
X-Delivery-Agent: TMDA v0.32/Python 2.1.1 (sunos5)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2001 at 02:30:20PM +0100, Alan Cox wrote:
> > >From what I've been able to find on Google, there are several other people
> > with this problem;  Has anyone come up with a solution?  I have ServerWorks
> > OSB4 support compiled into the kernel, but this happens with or without it.
> 
> The OSB4 support in Linus 2.4 tree is out of date. The chances are that is
> not the cause of the DMA timeout - but do try the 2.4.6-ac5 tree
> 
> And no there is no 2.4.6-ac5-xfs tree I know of, if you need that you'll
> have to merge stuff

Apologies for the followup to the ancient post, but I've looked at the
differences between the serverworks.c in the current 2.4.14 kernel and the 
most recent -ac patch, and there are less than 30 lines changed.  Does this 
mean that the OSB4 support in the Linus kernel is now up to date?

I ask because I'm still having major problems with the OSB4 chipset on
2.4.14.  I've had to disable DMA completely on my boxes to avoid IDE errors
and fs corruption.  Does anyone know of a patch that addresses the issues
with this chipset?

--Adam
-- 
Adam McKenna <adam@flounder.net>   | GPG: 17A4 11F7 5E7E C2E7 08AA
http://flounder.net/publickey.html |      38B0 05D0 8BF7 2C6D 110A
