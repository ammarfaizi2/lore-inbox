Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTDGRPn (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263562AbTDGRPn (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:15:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:40637 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263561AbTDGRPm (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 13:15:42 -0400
Date: Mon, 7 Apr 2003 08:58:58 -0700
From: Greg KH <greg@kroah.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: USB optical mouse on laptop causes bk12 boot to hang
Message-ID: <20030407155858.GA2553@kroah.com>
References: <Pine.LNX.4.44.0304070918200.1380-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304070918200.1380-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 09:23:19AM -0400, Robert P. J. Day wrote:
> 
>   on to the next issue.  the setup:
> 	dell inspiron 8100 laptop
> 	RH 9
> 	2.5.66-bk12
> 
>   for ergonomic reasons, rather than use the laptop keyboard and
> touchpad, i have (under the previous RH 8 and 2.4.20) been using
> an external PS/2 keyboard and logitech USB optical mouse.  this
> setup has been working fine -- when both external input devices
> are connected, i can use either keyboard, and just the optical
> USB mouse.
> 
>   booting under 2.5.66-bk12, if just the keyboard is connected,
> no problem.  the boot works, both keyboards are active, and the
> touchpad works.
> 
>   however, if i connect *only* the optical mouse, the boot gets
> to "Freeing unused kernel memory", hangs for about a minute, 
> then powers down the box.  not good.  (same thing happens if 
> both external keyboard and mouse are connected, so i've isolated
> it to just the optical mouse).

What happens when you plug in the mouse, after the boot process has
completed?

thanks,

greg k-h
