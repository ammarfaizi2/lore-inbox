Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311654AbSCNQuH>; Thu, 14 Mar 2002 11:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311667AbSCNQt7>; Thu, 14 Mar 2002 11:49:59 -0500
Received: from arsenal.visi.net ([206.246.194.60]:60923 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S311654AbSCNQtp>;
	Thu, 14 Mar 2002 11:49:45 -0500
Date: Thu, 14 Mar 2002 11:46:03 -0500
From: Ben Collins <bcollins@debian.org>
To: Hansen Martin <DKDD0MAR@Danfoss.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing serial device from within
Message-ID: <20020314164603.GB4789@blimpo.internal.net>
In-Reply-To: <829F632D2F25D411B6920008C716F831039FB26C@dd01-e01.drives.danfoss.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829F632D2F25D411B6920008C716F831039FB26C@dd01-e01.drives.danfoss.dk>
User-Agent: Mutt/1.3.27i
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

The question is, why do this in the kernel, when it is more easily
handled in userspace?

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/       Ben Collins    --    Debian GNU/Linux    --    WatchGuard.com      \
`          bcollins@debian.org   --   Ben.Collins@watchguard.com           '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
