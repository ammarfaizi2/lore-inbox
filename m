Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTAJFEQ>; Fri, 10 Jan 2003 00:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTAJFEQ>; Fri, 10 Jan 2003 00:04:16 -0500
Received: from adsl-66-112-90-25-rb.spt.centurytel.net ([66.112.90.25]:4736
	"EHLO carthage") by vger.kernel.org with ESMTP id <S262796AbTAJFEP>;
	Fri, 10 Jan 2003 00:04:15 -0500
Date: Thu, 9 Jan 2003 23:12:57 -0600
From: James Curbo <phoenix@sandwich.net>
To: Ross Biro <rossb@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA timeouts on Promise 20267 IDE card
Message-ID: <20030110051257.GB411@carthage>
Reply-To: James Curbo <phoenix@sandwich.net>
References: <20030109204350.GA413@carthage> <3E1DEF29.8020900@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1DEF29.8020900@google.com>
User-Agent: Mutt/1.4i
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 09, Ross Biro wrote:

> I believe the low bit set in the dma_status means that the DMA transfer 
> is still in progress.  Since the timer has expired, that means it's been 
> in progress for 10 seconds.  Odds are the drive has stopped responding. 
> Since it's a Western Digital drive, it probably needs to be powercycled 
> to come back.
> 
> I don't think this is a problem with the controller card, but I could be 
> wrong.
> 
>    Ross
> 

Well, I have had the first drive for about a year and a half (I think) 
and the second drive since August. I never had any problems out of them
with the same controller card on my previous motherboard (MSI K7T
Turbo). The problems didn't arise until the other day when I got my new
board.

The errors occur over and over; the drive will come back for a few
seconds and then the error will occur again. I usually reboot at this
point.

-- 
James Curbo <hannibal@adtrw.org> <phoenix@sandwich.net>
http://www.adtrw.org/blogs/hannibal/
