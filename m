Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVK0QUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVK0QUw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 11:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVK0QUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 11:20:52 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:3341 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751100AbVK0QUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 11:20:51 -0500
Date: Sun, 27 Nov 2005 17:20:48 +0100
From: Willy Tarreau <willy@w.ods.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alternatives to serial console for oops.
Message-ID: <20051127162048.GP11266@alpha.home.local>
References: <4389D63B.4000702@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4389D63B.4000702@superbug.demon.co.uk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 27, 2005 at 03:52:27PM +0000, James Courtier-Dutton wrote:
> Hi,
> 
> I wish to view the oops that are normally output on the serial port of 
> the PC. The problem I have, is that my PC does not have a serial port.
> Are there any alternatives for getting that vital oops from the kernel 
> just as it crashes apart from the serial console.
> Could I get it to use some other interface? e.g. Network interface.
> Parallel port is also not an option.

The netconsole patch should let you send it over a network interface,
but I've not used it much so I won't be able to help. kmsgdump will
let you write it on a floppy disk, but I bet that you don't have any
if you don't have any serial nor parallel ports.

VMWare may help if you are mainly trying to debug a kernel and not
using it for production.

Regards,
Willy

