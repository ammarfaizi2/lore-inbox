Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266854AbSL3LJg>; Mon, 30 Dec 2002 06:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbSL3LJg>; Mon, 30 Dec 2002 06:09:36 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:57283 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266854AbSL3LJf>;
	Mon, 30 Dec 2002 06:09:35 -0500
Date: Mon, 30 Dec 2002 11:16:14 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Paul Rolland <rol@as2917.net>
Cc: "'zhaoway'" <zw@netspeed-tech.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Kernel configuration in kernel, kernel 2.5.53
Message-ID: <20021230111613.GA11633@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Paul Rolland <rol@as2917.net>, 'zhaoway' <zw@netspeed-tech.com>,
	linux-kernel@vger.kernel.org
References: <3E0F3C6F.3090701@netspeed-tech.com> <00c501c2af69$b79cab00$2101a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c501c2af69$b79cab00$2101a8c0@witbe>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 07:40:09PM +0100, Paul Rolland wrote:
 > > 
 > > You could write a simple script to install a kernel image and 
 > > install the .config under /boot as well. Guess that solves your 
 > > problem better.
 > > 
 > Yes, but this still makes the configuration something external to
 > the kernel, thus it is still possible to have a mismatch between
 > the kernel and this file, and this is what I'm trying to avoid :-)

Google for Randy Dunlaps ikconfig patches.
They solve the problem by appending the .config to the kernel image,
thus not bloating any kernel space memory with /proc junk.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
