Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbSK1RlW>; Thu, 28 Nov 2002 12:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266553AbSK1RlW>; Thu, 28 Nov 2002 12:41:22 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:5098 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266552AbSK1RlV>;
	Thu, 28 Nov 2002 12:41:21 -0500
Date: Thu, 28 Nov 2002 17:46:32 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd ext3 problem with 2.5.50
Message-ID: <20021128174632.GD930@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021128172619.GA930@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021128172619.GA930@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 05:26:19PM +0000, Dave Jones wrote:
 > Erm. Whats going on here ?
 > 
 > (davej@tetrachloride:davej)$ ls .viminfo
 > ls: .viminfo: No such file or directory
 > (davej@tetrachloride:davej)$ touch .viminfo
 > touch: creating `.viminfo': File exists
 > (davej@tetrachloride:davej)$ 

problem solved - The fs/namei.c patch already posted
seems to have fixed this.

		Dave
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
