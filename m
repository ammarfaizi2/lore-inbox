Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131479AbRDNJbR>; Sat, 14 Apr 2001 05:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131631AbRDNJbI>; Sat, 14 Apr 2001 05:31:08 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:32529 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131479AbRDNJbB> convert rfc822-to-8bit; Sat, 14 Apr 2001 05:31:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Peter <ujq7@rz.uni-karlsruhe.de>
To: linux-kernel@vger.kernel.org
Subject: Re: SW-RAID0 Performance problems
Date: Sat, 14 Apr 2001 11:38:06 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10104131048550.1669-100000@coffee.psychology.mcmaster.ca> <01041318282003.00665@debian> <20010414000433.F4557@greenhydrant.com>
In-Reply-To: <20010414000433.F4557@greenhydrant.com>
MIME-Version: 1.0
Message-Id: <01041411380600.00516@debian>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 14. April 2001 09:04 schrieb David Rees:

> OK, so it's not the RAID setup.  There's two things that can cause this.
> One is that DMA is turned off  (what does hdparm /dev/hda and hdparm
> /dev/hdc show?), the second was that the drives are on the same channel
> (which obviously isn't the case here).  Can you verify that the drives are
> in DMA mode?

hdparm /dev/hda 

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 59556/16/63, sectors = 60032448, start = 0

the same on /dev/hdc

I played with different hdparm-settings, but it's not possible to speed up 
the HDs

Andreas
-- 
Andreas Peter *** ujq7@rz.uni-karlsruhe.de

