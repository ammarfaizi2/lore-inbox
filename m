Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbUKCSec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUKCSec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 13:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUKCSec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 13:34:32 -0500
Received: from fep19.inet.fi ([194.251.242.244]:25025 "EHLO fep19.inet.fi")
	by vger.kernel.org with ESMTP id S261787AbUKCSe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 13:34:29 -0500
Date: Wed, 3 Nov 2004 20:34:25 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB CD/disk not working after 2.6.7
Message-ID: <20041103183425.GB13063@m.safari.iki.fi>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4189137A.2090408@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4189137A.2090408@tmr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 12:20:58PM -0500, Bill Davidsen wrote:
> Since 2.6.7 no kernel has seen my USB CD burner or disk. I took the disk 
> off to simplify the picture, it still doesn't work.
...
> Buffer I/O error on device uba, logical block 0
>  unable to read partition table

remove this line from .config and rebuild kernel...
CONFIG_BLK_DEV_UB=y

...and it will just work.

-- 
