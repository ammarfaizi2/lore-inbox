Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290782AbSAYSpq>; Fri, 25 Jan 2002 13:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290779AbSAYSph>; Fri, 25 Jan 2002 13:45:37 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:22288 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S290783AbSAYSp0>; Fri, 25 Jan 2002 13:45:26 -0500
Date: Fri, 25 Jan 2002 12:23:39 +0000
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Message-ID: <20020125122339.A1714@sackman.co.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201232018530.2202-100000@infcip10.uni-trier.de> <E16TZhr-00049f-00@mxng04.kundenserver.de> <20020124125914.0B3ED13D1@shrek.lisa.de> <1011882217.22707.19.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <1011882217.22707.19.camel@psuedomode>; from ed.sweetman@wmich.edu on Thu, Jan 24, 2002 at 09:23:32AM -0500
From: matthew@sackman.co.uk (Matthew Sackman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 09:23:32AM -0500, Ed Sweetman wrote:
> 
> > I thought, ntpd would take care of the RTC:
> 
> It doesn't.  init scripts on boot sync the date to the rtc, if your date
> isn't near what it should be then ntp wont work.  It has to at least be
> close then run date --systohc or something like that. 

Which is why it's a good idea to have ntpdate run on startup to get the
clock sync'd to one ntp server and then that will guarentee that ntpd will
start up happily and be happy etc.

Matthew

-- 

Matthew Sackman
Nottingham
England

BOFH Excuse Board:
excessive collisions & not enough packet ambulances
