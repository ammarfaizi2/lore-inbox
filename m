Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbUJ3WOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbUJ3WOR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbUJ3WOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:14:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7172 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261353AbUJ3WMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:12:03 -0400
Date: Sat, 30 Oct 2004 23:11:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let FW_LOADER select HOTPLUG
Message-ID: <20041030231156.E15392@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20041030220309.GE4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041030220309.GE4374@stusta.de>; from bunk@stusta.de on Sun, Oct 31, 2004 at 12:03:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 12:03:09AM +0200, Adrian Bunk wrote:
> 
> If it wasn't for external modules, FW_LOADER wasn't user-visible.
> Let FW_LOADER select HOTPLUG To make the dependencies easier for users.

You know what I'm going to say about this patch, so I'll won't repeat,
except to say it has to do with select on user visible symbols.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
