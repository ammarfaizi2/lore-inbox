Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270132AbRH1BlC>; Mon, 27 Aug 2001 21:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270121AbRH1Bkx>; Mon, 27 Aug 2001 21:40:53 -0400
Received: from ohiper1-230.apex.net ([209.250.47.245]:62469 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S270090AbRH1Bkf>; Mon, 27 Aug 2001 21:40:35 -0400
Date: Mon, 27 Aug 2001 20:39:49 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: v4l interface questions
Message-ID: <20010827203949.B19422@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20010827231126.A21664@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010827231126.A21664@bug.ucw.cz>; from pavel@suse.cz on Mon, Aug 27, 2001 at 11:11:26PM +0200
X-Uptime: 5:36pm  up 1 day, 13 min,  0 users,  load average: 1.02, 1.05, 1.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 11:11:26PM +0200, Pavel Machek wrote:
> I have device (vicam == usb 3com homeconnect camera), which would like to
> fit into v4l framework. But... mmap is not really native operation for
> usb. Should I emulate it, or just return unsupported and expect
> applications to use read()?
> 
> Similar problem is there with formats. vicam has some really strange
> formats. Should I do conversion in kernel?

Don't do conversion in the kernel.

> Is there some usermode program that can handle camera without mmap
> ability and can support arbitrary screen sizes + 16bpp grayscale?
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
