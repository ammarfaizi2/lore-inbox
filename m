Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290874AbSAaDQV>; Wed, 30 Jan 2002 22:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290873AbSAaDQL>; Wed, 30 Jan 2002 22:16:11 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59619 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290870AbSAaDQH>;
	Wed, 30 Jan 2002 22:16:07 -0500
Date: Wed, 30 Jan 2002 22:16:05 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Tim Coleman <tim@timcoleman.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.1
Message-ID: <20020130221605.C22862@havoc.gtf.org>
In-Reply-To: <1012445595.7956.4.camel@tux.epenguin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1012445595.7956.4.camel@tux.epenguin.org>; from tim@timcoleman.com on Wed, Jan 30, 2002 at 09:53:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:53:13PM -0500, Tim Coleman wrote:
> I got an oops when loading usb with hotplug in kernel 2.5.1
> I realize that this isn't the current version but I thought
> I would send it in anyway, because I haven't got 2.5.3 yet.
> 
> The device is not accessible at all with this kernel, and I notice
> that the trace mentions the 8139_too ethernet driver.

Can you rebuild with 8139too and USB inside the kernel, instead of
modules, and attempt to reproduce?

8139 has a bunch of assert() calls in that area, which make me doubt the
veracity of the ksymoops output :/

Also make sure you are sending the oops through the proper system.map...

	Jeff




