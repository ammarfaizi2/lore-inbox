Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267253AbTBDM3a>; Tue, 4 Feb 2003 07:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBDM3a>; Tue, 4 Feb 2003 07:29:30 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:8602 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267246AbTBDM33>;
	Tue, 4 Feb 2003 07:29:29 -0500
Date: Tue, 4 Feb 2003 12:33:58 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
Message-ID: <20030204123358.GB29160@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1044284924.2402.12.camel@gregs> <1044289102.21009.1.camel@irongate.swansea.linux.org.uk> <1044286828.2397.26.camel@gregs> <1044292722.21009.9.camel@irongate.swansea.linux.org.uk> <1044312846.28406.31.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044312846.28406.31.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 10:54:06PM +0000, David Woodhouse wrote:

 > GCC is likewise perfectly entitled to use floating point even if you
 > only used integers in the source. There's a good reason why the SH port
 > builds with '-mno-implicit-fp' and why all other ports should have this
 > _before_ it becomes a problem rather than afterwards.

I was wondering about this yesterday when toying with the -march options
we now pass. With (for eg) -march=c3, we now tell gcc it can emit 3dnow
instructions if it wants, likewise SSE/SSE2 in other -march options.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
