Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311669AbSCNQvr>; Thu, 14 Mar 2002 11:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311668AbSCNQvl>; Thu, 14 Mar 2002 11:51:41 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:45830 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311669AbSCNQur>; Thu, 14 Mar 2002 11:50:47 -0500
Date: Thu, 14 Mar 2002 17:50:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hansen Martin <DKDD0MAR@Danfoss.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing serial device from within
Message-ID: <20020314175045.A14754@ucw.cz>
In-Reply-To: <829F632D2F25D411B6920008C716F831039FB26C@dd01-e01.drives.danfoss.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <829F632D2F25D411B6920008C716F831039FB26C@dd01-e01.drives.danfoss.dk>; from DKDD0MAR@Danfoss.com on Thu, Mar 14, 2002 at 05:40:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 05:40:12PM +0100, Hansen Martin wrote:
> I am writing a module, that will communicate with a device attached to the
> serial port.
> 
>  How can I do that from inside a module, using the present uart driver?
> I want to do something like finding and calling the read/write routine that
> is called by the kernel when a process from user space accesses the
> /dev/ttyS1.
> 
> The reason I want to do it this way is that I don't want my module to only
> fit one uart.

You have to write what's called a line discipline driver.

-- 
Vojtech Pavlik
SuSE Labs
