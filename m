Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbSALE72>; Fri, 11 Jan 2002 23:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284809AbSALE7S>; Fri, 11 Jan 2002 23:59:18 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:1600 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S284794AbSALE7J>; Fri, 11 Jan 2002 23:59:09 -0500
From: brian@worldcontrol.com
Date: Fri, 11 Jan 2002 20:57:31 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CIPE vs. GPLONLY_
Message-ID: <20020112045731.GA3788@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020112010317.GA1765@top.worldcontrol.com> <E16PD12-0000wY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16PD12-0000wY-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23.2i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 01:31:24AM +0000, Alan Cox wrote:
> > running CIPE 1.5.2 I get the error above.  Should I be bother the
> > CIPE people with this?  Or is this some kernel thingy that needs
> > to be dealt with?
> 
> Add
> 
> 	MODULE_LICENSE("GPL");
> 
> to the cipe code and all will be well

As I posted in another email. The above changed helped but I still
had one undef'ed reference.

I removed my linux source tree, rebuilt everything, and now it
works fine.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2002 By Brian Litzinger, All Rights Reserved
