Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318415AbSGaRgf>; Wed, 31 Jul 2002 13:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318416AbSGaRgf>; Wed, 31 Jul 2002 13:36:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58383 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318415AbSGaRge>; Wed, 31 Jul 2002 13:36:34 -0400
Date: Wed, 31 Jul 2002 18:39:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: devfs and tty layer.
Message-ID: <20020731183957.B18153@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207311026580.13905-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207311026580.13905-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Wed, Jul 31, 2002 at 10:37:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 10:37:15AM -0700, James Simmons wrote:
>    As you already seen there has been a issue with devfs and the VT code.
> I have moved the tty registeration later for VTs so the TTY_DRIVER_NO_DEVFS
> flag was no longer needed.

It's needed for serial.  Please don't remove it just yet.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

