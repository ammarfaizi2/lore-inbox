Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTCCL20>; Mon, 3 Mar 2003 06:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbTCCL20>; Mon, 3 Mar 2003 06:28:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39176 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263366AbTCCL2Z>; Mon, 3 Mar 2003 06:28:25 -0500
Date: Mon, 3 Mar 2003 11:38:49 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: roman duka <unixfreak@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:
Message-ID: <20030303113849.B16365@flint.arm.linux.org.uk>
Mail-Followup-To: roman duka <unixfreak@ntlworld.com>,
	linux-kernel@vger.kernel.org
References: <20030303110737.45d91d6b.unixfreak@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030303110737.45d91d6b.unixfreak@ntlworld.com>; from unixfreak@ntlworld.com on Mon, Mar 03, 2003 at 11:07:37AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 11:07:37AM +0000, roman duka wrote:
> if i go to /usr/src/linux and edit Makefile and replace the line:
> 
> ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
> 
> with:
> 
> ARCH := arm
> 
> and then run 'make menuconfig' menuconfig goes into infinite loop and
> gets killed when it uses up all available memory. any ideas how to fix
> this problem??

It's probably a known problem that should be fixed in the -rmk patches.
You don't say what kernel version you're using though, or whether you've
applied these patches (which you'll need to build for ARM anyway.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

