Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282671AbRLBBxF>; Sat, 1 Dec 2001 20:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282672AbRLBBwz>; Sat, 1 Dec 2001 20:52:55 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:29273 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282671AbRLBBwt>; Sat, 1 Dec 2001 20:52:49 -0500
Date: Sat, 1 Dec 2001 20:52:48 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Wrapping memory.
Message-ID: <20011201205247.B31466@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112012249440.15977-100000@druid.if.uj.edu.pl> <E16AIZ8-0008Re-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16AIZ8-0008Re-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 01, 2001 at 10:24:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 10:24:58PM +0000, Alan Cox wrote:
> > Is this at all possible? If so, how would I do this in user space (and
> > could it be done without root priv?)?
> 
> mmap will do what you need. Create a 60K object on disk and mmap it
> at the base address and then 60K further on for 4K. 

And try to use /dev/shm/ first...

		-ben
