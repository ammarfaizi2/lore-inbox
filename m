Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293452AbSCWQHR>; Sat, 23 Mar 2002 11:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293515AbSCWQHI>; Sat, 23 Mar 2002 11:07:08 -0500
Received: from ohiper3-167.apex.net ([209.250.52.182]:56846 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S293452AbSCWQG4>; Sat, 23 Mar 2002 11:06:56 -0500
Date: Sat, 23 Mar 2002 10:06:47 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Screen corruption in 2.4.18
Message-ID: <20020323160647.GA22958@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Danijel Schiavuzzi <dschiavu@public.srce.hr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <200203222204.XAA01121@jagor.srce.hr> <20020322232304.GA19579@hapablap.dyn.dhs.org> <200203231526.QAA09302@jagor.srce.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uptime: 09:31:19 up 2 days,  8:28,  0 users,  load average: 0.50, 0.89, 0.95
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2002 at 04:25:55PM +0100, Danijel Schiavuzzi wrote:
> > I think you actually do have an 8363, and so some sort of fix is
> > probably needed.
> 
> Don't get it wrong. I *do have* an VT8365. VT8365 (ProSavage KM133) is 
> somewhat the same as VT8363 (KT133), except that 8365 has an integrated 
> Savage graphics card (which *I use*).

Aha... I see.  And in thinking about it, I realize that my motherboard
also has this integrated graphics card.  Perhaps this is the difference?
Unfortunately, it seems they both report the same PCI id, so I don't
really know of a way to differentiate them.

[...]
> In the KM133 datasheet (find it here: http://www.fae.com.tw/serv02.htm ;) it 
> is said that the offset 55 is for "Debug (Do Not Program)"... Can you look at 
> it, maybe it can help.

I looked at that datasheet, and the datasheet for the 8363.  Both said
not to program offset 55, and both said the bits we are clearing are
"reserved."  Perhaps we should contact VIA directly, tell them the
problem we're having with their current fix, tell them our theory, and
ask if we're right.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
