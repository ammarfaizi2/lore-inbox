Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSLMRy1>; Fri, 13 Dec 2002 12:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSLMRy1>; Fri, 13 Dec 2002 12:54:27 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:64582 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261448AbSLMRy0>;
	Fri, 13 Dec 2002 12:54:26 -0500
Date: Fri, 13 Dec 2002 19:02:15 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51: new warning from lilo
Message-ID: <20021213180215.GA10777@win.tue.nl>
References: <20021212193451.GA458@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021212193451.GA458@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 08:34:51PM +0100, Pavel Machek wrote:
> Lilo now presents me with new warning:
> 
> Warning: Kernel & BIOS return differing head/sector geometries for
> device 0x80
>     Kernel: 8944 cylidners, 15 heads, 63 sectors
>       BIOS: 525 cylinders, 255 heads, 63 sectors
> 
> lilo did not warn under 2.5.50. Now... Will it boot?

That depends on the options you gave it.
With linear or lba32 the geometry does not play any role.
If you don't give these options then the geometry does play
a role, at least for the versions of LILO I have looked at.
You can give LILO explicit geometry options if for some
reason you do not want to use "linear".

Andries
