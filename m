Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSFQPVY>; Mon, 17 Jun 2002 11:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSFQPVX>; Mon, 17 Jun 2002 11:21:23 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:26632 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314396AbSFQPVW>;
	Mon, 17 Jun 2002 11:21:22 -0400
Date: Mon, 17 Jun 2002 08:20:33 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       NAGANO Daisuke <breeze.nagano@nifty.ne.jp>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5 patch] drivers/usb/class/usb-midi.c must include linux/version.h
Message-ID: <20020617152033.GA14164@kroah.com>
References: <Pine.NEB.4.44.0206171706550.1866-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0206171706550.1866-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 20 May 2002 14:18:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 05:11:57PM +0200, Adrian Bunk wrote:
> 
> The fix is simple:

<snip>

No, the fix is even easier, I'll remove that #if from the driver, it is
not needed.

thanks,

greg k-h
