Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288308AbSBEEs3>; Mon, 4 Feb 2002 23:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288338AbSBEEsT>; Mon, 4 Feb 2002 23:48:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56594 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288308AbSBEEsP>; Mon, 4 Feb 2002 23:48:15 -0500
Message-ID: <3C5F63F8.90808@zytor.com>
Date: Mon, 04 Feb 2002 20:47:52 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Calin A. Culianu" <calin@ajvar.org>
CC: Stevie O <stevie@qrpff.net>, linux-kernel@vger.kernel.org
Subject: Re: Asynchronous CDROM Events in Userland
In-Reply-To: <Pine.LNX.4.30.0202042341030.31336-100000@rtlab.med.cornell.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calin A. Culianu wrote:

>>>
>>Does it spin up the CD-ROM doing so?
>>
> 
> Probably it doesn't, but just having the cpu be non-idle when it could
> otherwise be idle does add up over time.  In linux, polling the cdrom
> *seems* inexpensive enough, but if you look at 'top' it seems to average
> out to like 1-2% cpu time!  (Ok, these stats aren't super-accurate,
> they're just from running 'top' with the kde autorun tool running).
> 
> [Admitedly, the autorun tool is written kind of strangely (it does one
> redundant ioctl, plus it wait()s on its children constantly rather than
> installing a signal handler), but still.. it would be nice to get those
> extra cycles for quake3 or wolfenstein...]
> 


That just indicates a bullsh*t program.  It's also pretty certain that 
these kinds of things don't belong in the GUI; one of the things I'd 
like to do at some point is to write a daemon to mount things on insert 
(vold).

	-hpa


